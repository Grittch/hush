import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_note.freezed.dart';

@freezed
abstract class VoiceNoteId with _$VoiceNoteId {
  const factory VoiceNoteId({
    required String fileName,
    required int sizeBytes,
  }) = _VoiceNoteId;

  const VoiceNoteId._();

  // Chiave stabile per lo stato persistito: l'URI SAF puo cambiare e
  // lastModified viene riscritto dai backup, i byte di un vocale mai.
  String get storageKey => '$fileName|$sizeBytes';
}

@freezed
abstract class PlaybackProgress with _$PlaybackProgress {
  const factory PlaybackProgress({
    required Duration position,
    Duration? duration,
    DateTime? playedAt,

    /// Una misura della durata e stata tentata ed e fallita. Serve a non
    /// ritentarla a ogni avvio: senza questo, i file che non si riescono a
    /// decodificare vengono rimisurati per sempre.
    @Default(false) bool durationUnavailable,
  }) = _PlaybackProgress;

  const PlaybackProgress._();

  bool get isPlayed => playedAt != null;

  bool get hasResumePoint => position > Duration.zero;

  bool get needsDurationMeasure => duration == null && !durationUnavailable;
}

@freezed
abstract class VoiceNote with _$VoiceNote {
  const factory VoiceNote({
    required VoiceNoteId id,
    required String sourceUri,
    required DateTime receivedAt,
    DateTime? nameDay,
    int? sequence,
    PlaybackProgress? progress,
  }) = _VoiceNote;

  const VoiceNote._();

  /// Il giorno nel nome file e stabile ma senza orario; `receivedAt` porta
  /// l'orario ma puo essere stato riscritto da un backup, quindi il
  /// raggruppamento preferisce il primo quando c'e.
  DateTime get day =>
      nameDay ?? DateTime(receivedAt.year, receivedAt.month, receivedAt.day);

  /// Falso quando `receivedAt` cade fuori dal giorno dichiarato dal nome file:
  /// un ripristino da backup riscrive la data di modifica, e mostrare
  /// quell'orario lo farebbe passare per il momento di ricezione.
  bool get hasReliableTime {
    final fromName = nameDay;
    if (fromName == null) return true;
    return receivedAt.year == fromName.year &&
        receivedAt.month == fromName.month &&
        receivedAt.day == fromName.day;
  }

  /// Ordinamento dentro la giornata: il progressivo di WhatsApp quando c'e,
  /// perche sopravvive ai ripristini che appiattiscono `receivedAt`.
  int get orderWithinDay => sequence ?? receivedAt.millisecondsSinceEpoch;

  String get fileName => id.fileName;

  int get sizeBytes => id.sizeBytes;

  Duration? get duration => progress?.duration;

  Duration get resumePosition => progress?.position ?? Duration.zero;

  bool get isUnplayed => progress?.isPlayed != true;
}
