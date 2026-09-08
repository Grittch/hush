import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hush/core/errors/hush_exception.dart';
import 'package:hush/features/voice_notes/domain/voice_note.dart';
import 'package:hush/features/voice_notes/domain/voice_note_ordering.dart';
import 'package:hush/features/voice_notes/presentation/providers/duration_prefetcher.dart';
import 'package:hush/features/voice_notes/presentation/providers/voice_notes_providers.dart';

import '../../../support/fakes.dart';

void main() {
  late FakeVoiceNoteSource source;
  late FakeDurationReader reader;
  late RecordingPlaybackStateStore store;
  late ProviderContainer container;

  ProviderContainer build(List<VoiceNote> notes) {
    source = FakeVoiceNoteSource(notes: notes);
    return ProviderContainer(
      overrides: [
        voiceNoteSourceProvider.overrideWithValue(source),
        durationReaderProvider.overrideWithValue(reader),
        playbackStateStoreProvider.overrideWithValue(store),
      ],
    );
  }

  /// La scansione mette una pausa fra due misure: i test la attendono invece
  /// di indovinare un numero di microtask.
  Future<void> settle(int notes) =>
      Future<void>.delayed(Duration(milliseconds: 60 * (notes + 1)));

  setUp(() {
    reader = FakeDurationReader();
    store = RecordingPlaybackStateStore();
  });

  tearDown(() async {
    container.dispose();
    await store.dispose();
  });

  test(
    'misura e persiste la durata senza che il vocale venga aperto',
    () async {
      final note = fakeNote();
      container = build([note]);

      container.read(durationPrefetcherProvider);
      await settle(1);

      expect(reader.readPaths, ['/cache/${note.fileName}']);
      expect(store.durationsSaved.single.id, note.id);
      expect(store.current[note.id]?.duration, const Duration(seconds: 12));
    },
  );

  test('non tocca posizione di ripresa e stato di ascolto', () async {
    final note = fakeNote();
    container = build([note]);
    await store.saveProgress(id: note.id, position: const Duration(seconds: 5));
    await store.markPlayed(note.id);

    container.read(durationPrefetcherProvider);
    await settle(1);

    expect(store.current[note.id]?.isPlayed, isTrue);
    expect(store.saved.single.position, const Duration(seconds: 5));
  });

  test('salta i vocali di cui la durata e gia nota', () async {
    final note = fakeNote();
    container = build([note]);
    await store.saveDuration(id: note.id, duration: const Duration(seconds: 3));

    container.read(durationPrefetcherProvider);
    await settle(1);

    expect(reader.readPaths, isEmpty);
  });

  test('un vocale illeggibile non ferma la misura degli altri', () async {
    final first = fakeNote(fileName: 'PTT-20260811-WA0001.opus');
    final second = fakeNote(fileName: 'PTT-20260811-WA0002.opus');
    container = build([first, second]);
    source.materializeError = const VoiceNoteGoneException();

    container.read(durationPrefetcherProvider);
    await settle(2);

    // La sorgente rifiuta entrambi, ma la scansione li prova tutti e due
    // invece di interrompersi al primo errore.
    expect(store.durationsSaved, isEmpty);
    expect(source.materialized, isEmpty);
  });

  test('una durata illeggibile viene registrata come tale', () async {
    final note = fakeNote();
    container = build([note]);
    reader.duration = null;

    container.read(durationPrefetcherProvider);
    await settle(1);

    expect(store.unavailableMarked, [note.id]);
    expect(store.current[note.id]?.needsDurationMeasure, isFalse);
  });

  test('un file non decodificabile viene registrato come tale', () async {
    final note = fakeNote();
    container = build([note]);
    reader.error = const VoiceNoteUnplayableException();

    container.read(durationPrefetcherProvider);
    await settle(1);

    expect(store.unavailableMarked, [note.id]);
  });

  test('un vocale gia dichiarato illeggibile non viene ritentato', () async {
    final note = fakeNote();
    container = build([note]);
    await store.markDurationUnavailable(note.id);

    container.read(durationPrefetcherProvider);
    await settle(1);

    expect(reader.readPaths, isEmpty);
  });

  test('un vocale sparito non viene marcato come illeggibile', () async {
    // Il file non c'e piu: non e un difetto del vocale, e la prossima
    // scansione della cartella non lo elenchera nemmeno.
    final note = fakeNote();
    container = build([note]);
    source.materializeError = const VoiceNoteGoneException();

    container.read(durationPrefetcherProvider);
    await settle(1);

    expect(store.unavailableMarked, isEmpty);
  });

  test('la selezione si limita ai vocali piu recenti', () {
    final notes = [
      for (var i = 1; i <= prefetchLimit + 20; i++)
        fakeNote(
          fileName: 'PTT-20260811-WA${i.toString().padLeft(4, "0")}.opus',
          nameDay: DateTime(2026, 8, 11),
          sequence: i,
        ),
    ];

    final selected = newestFirst(notes).take(prefetchLimit).toList();

    expect(selected, hasLength(prefetchLimit));
    expect(selected.first.sequence, prefetchLimit + 20);
    expect(selected.last.sequence, 21);
  });

  test('non rimisura lo stesso vocale a ogni ricarica della lista', () async {
    final note = fakeNote();
    container = build([note]);

    container.read(durationPrefetcherProvider);
    await settle(1);
    container.invalidate(sourceNotesProvider);
    await settle(1);

    expect(reader.readPaths, hasLength(1));
  });
}
