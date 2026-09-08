import 'package:flutter_test/flutter_test.dart';
import 'package:hush/features/voice_notes/domain/voice_note.dart';
import 'package:hush/features/voice_notes/domain/voice_note_group.dart';

VoiceNote note({
  required String fileName,
  required DateTime receivedAt,
  DateTime? nameDay,
  int sizeBytes = 1000,
}) {
  return VoiceNote(
    id: VoiceNoteId(fileName: fileName, sizeBytes: sizeBytes),
    sourceUri: 'content://tree/$fileName',
    receivedAt: receivedAt,
    nameDay: nameDay,
  );
}

void main() {
  group('groupByDay', () {
    test('non produce gruppi per una lista vuota', () {
      expect(groupByDay(const [], const {}), isEmpty);
    });

    test('raggruppa per giorno e ordina dal piu recente', () {
      final groups = groupByDay([
        note(fileName: 'a.opus', receivedAt: DateTime(2026, 8, 10, 9)),
        note(fileName: 'b.opus', receivedAt: DateTime(2026, 8, 12, 9)),
        note(fileName: 'c.opus', receivedAt: DateTime(2026, 8, 10, 18)),
      ], const {});

      expect(groups.map((group) => group.day), [
        DateTime(2026, 8, 12),
        DateTime(2026, 8, 10),
      ]);
      expect(groups.last.notes.map((n) => n.fileName), ['c.opus', 'a.opus']);
    });

    test('preferisce il giorno del nome file a lastModified riscritto', () {
      final groups = groupByDay([
        note(
          fileName: 'PTT-20260811-WA0001.opus',
          receivedAt: DateTime(2026, 9, 1, 12),
          nameDay: DateTime(2026, 8, 11),
        ),
      ], const {});

      expect(groups.single.day, DateTime(2026, 8, 11));
    });

    test('applica lo stato di ascolto al vocale corrispondente', () {
      final played = VoiceNoteId(fileName: 'a.opus', sizeBytes: 1000);
      final groups = groupByDay(
        [
          note(fileName: 'a.opus', receivedAt: DateTime(2026, 8, 10)),
          note(fileName: 'b.opus', receivedAt: DateTime(2026, 8, 10)),
        ],
        {
          played: PlaybackProgress(
            position: const Duration(seconds: 4),
            duration: const Duration(seconds: 30),
            playedAt: DateTime(2026, 8, 11),
          ),
        },
      );

      final notes = groups.single.notes;
      final withState = notes.firstWhere((n) => n.fileName == 'a.opus');
      final withoutState = notes.firstWhere((n) => n.fileName == 'b.opus');

      expect(withState.isUnplayed, isFalse);
      expect(withState.duration, const Duration(seconds: 30));
      expect(withoutState.isUnplayed, isTrue);
      expect(withoutState.duration, isNull);
    });

    test(
      'due file con lo stesso nome ma dimensione diversa restano distinti',
      () {
        final groups = groupByDay(
          [
            note(fileName: 'a.opus', receivedAt: DateTime(2026, 8, 10)),
            note(
              fileName: 'a.opus',
              receivedAt: DateTime(2026, 8, 10),
              sizeBytes: 2000,
            ),
          ],
          {
            VoiceNoteId(fileName: 'a.opus', sizeBytes: 2000):
                const PlaybackProgress(position: Duration(seconds: 2)),
          },
        );

        final notes = groups.single.notes;
        expect(
          notes.where((n) => n.resumePosition > Duration.zero),
          hasLength(1),
        );
      },
    );
  });
}
