import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/hush_exception.dart';
import '../../domain/voice_note.dart';
import '../../domain/voice_note_ordering.dart';
import 'voice_notes_providers.dart';

part 'duration_prefetcher.g.dart';

/// Pausa fra due misure: la scansione non deve competere con la riproduzione
/// ne tenere occupato il thread della piattaforma.
const _pauseBetweenReads = Duration(milliseconds: 40);

/// Quanti vocali misurare in automatico, dai piu recenti. Un archivio di anni
/// contiene migliaia di file e ognuno costa una copia piu un decoder: oltre
/// questa soglia la durata si ricava quando il vocale viene aperto, che e il
/// momento in cui serve davvero.
const prefetchLimit = 200;

/// Riempie le durate mancanti subito dopo la scansione della cartella, invece
/// di aspettare che l'utente apra ogni vocale. La durata finisce in Drift, cosi
/// il costo si paga una volta sola per vocale e la lista si aggiorna da se.
@Riverpod(keepAlive: true)
class DurationPrefetcher extends _$DurationPrefetcher {
  final Set<VoiceNoteId> _attempted = {};
  bool _running = false;
  bool _disposed = false;

  @override
  void build() {
    ref.onDispose(() => _disposed = true);
    // Si ascolta solo l'elenco dei file: mettersi in ascolto anche delle
    // durate salvate creerebbe un ciclo, perche ogni scrittura riaprirebbe
    // la scansione.
    ref.listen(sourceNotesProvider, (previous, next) {
      final notes = next.value;
      if (notes != null) unawaited(_fillMissing(notes));
    }, fireImmediately: true);
  }

  Future<void> _fillMissing(List<VoiceNote> notes) async {
    if (_running) return;
    _running = true;
    try {
      final known = await ref.read(playbackStateStoreProvider).readAll();
      for (final note in newestFirst(notes).take(prefetchLimit)) {
        if (_disposed) return;
        final progress = known[note.id];
        if (progress != null && !progress.needsDurationMeasure) continue;
        if (!_attempted.add(note.id)) continue;
        await _measure(note);
        await Future<void>.delayed(_pauseBetweenReads);
      }
    } on SourceAccessLostException {
      // La cartella non e piu leggibile: la lista lo segnala gia da se, e una
      // scansione di sfondo non deve mostrare errori propri.
    } on HushException {
      // Nulla da fare qui: i casi per singolo vocale sono gestiti in `_measure`.
    } finally {
      _running = false;
    }
  }

  Future<void> _measure(VoiceNote note) async {
    final source = ref.read(voiceNoteSourceProvider);
    if (source == null) return;
    try {
      final path = await source.materialize(note);
      final duration = await ref.read(durationReaderProvider).read(path);
      if (_disposed) return;
      if (duration == null) {
        await _markUnavailable(note);
        return;
      }
      await ref
          .read(playbackStateStoreProvider)
          .saveDuration(id: note.id, duration: duration);
    } on VoiceNoteUnplayableException {
      // Il file non e decodificabile: e definitivo, va registrato per non
      // ritentarlo a ogni avvio.
      await _markUnavailable(note);
    } on VoiceNoteGoneException {
      // Sparito dalla sorgente: la prossima scansione non lo elenchera.
    } on SourceAccessLostException {
      rethrow; // Non e colpa di questo vocale: la passata va interrotta.
    } on HushException {
      // Spazio, store, sconosciuto: transitori, si ritenta al prossimo avvio.
    }
  }

  Future<void> _markUnavailable(VoiceNote note) async {
    try {
      await ref
          .read(playbackStateStoreProvider)
          .markDurationUnavailable(note.id);
    } on LocalStoreException {
      // Se non si riesce a scrivere il promemoria si ritentera piu avanti:
      // resta un fastidio, non un errore da mostrare.
    }
  }
}
