import 'voice_note.dart';

abstract interface class PlaybackStateStore {
  Stream<Map<VoiceNoteId, PlaybackProgress>> watchAll();

  /// Snapshot per chi non osserva la UI, come la scansione delle durate: un
  /// lavoro di sfondo non deve dipendere dalla prima emissione di uno stream.
  Future<Map<VoiceNoteId, PlaybackProgress>> readAll();

  Future<void> saveProgress({
    required VoiceNoteId id,
    required Duration position,
    Duration? duration,
  });

  /// Scrive solo la durata, senza toccare posizione di ripresa e stato di
  /// ascolto: la misura arriva da una scansione di sfondo, non da un ascolto.
  Future<void> saveDuration({
    required VoiceNoteId id,
    required Duration duration,
  });

  /// Registra che la durata non e ricavabile da questo file, cosi la scansione
  /// di sfondo non lo ritenta a ogni avvio.
  Future<void> markDurationUnavailable(VoiceNoteId id);

  Future<void> markPlayed(VoiceNoteId id);
}
