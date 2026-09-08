import 'package:freezed_annotation/freezed_annotation.dart';

import 'voice_note.dart';
import 'voice_note_ordering.dart';

part 'voice_note_group.freezed.dart';

@freezed
abstract class VoiceNoteGroup with _$VoiceNoteGroup {
  const factory VoiceNoteGroup({
    required DateTime day,
    required List<VoiceNote> notes,
  }) = _VoiceNoteGroup;
}

List<VoiceNoteGroup> groupByDay(
  List<VoiceNote> notes,
  Map<VoiceNoteId, PlaybackProgress> progress,
) {
  final byDay = <DateTime, List<VoiceNote>>{};
  for (final note in notes) {
    final withProgress = note.copyWith(progress: progress[note.id]);
    byDay.putIfAbsent(note.day, () => []).add(withProgress);
  }

  final byDayDescending = byDay.entries.toList()
    ..sort((a, b) => b.key.compareTo(a.key));
  return [
    for (final entry in byDayDescending)
      VoiceNoteGroup(
        day: entry.key,
        notes: entry.value..sort(compareNewestFirst),
      ),
  ];
}
