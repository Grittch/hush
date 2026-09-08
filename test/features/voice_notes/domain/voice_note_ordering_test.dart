import 'package:flutter_test/flutter_test.dart';
import 'package:hush/features/voice_notes/domain/voice_note_ordering.dart';

import '../../../support/fakes.dart';

void main() {
  group('newestFirst', () {
    test('mette prima il giorno piu recente', () {
      final ordered = newestFirst([
        fakeNote(fileName: 'vecchio.opus', receivedAt: DateTime(2026, 8, 1)),
        fakeNote(fileName: 'nuovo.opus', receivedAt: DateTime(2026, 8, 20)),
        fakeNote(fileName: 'mezzo.opus', receivedAt: DateTime(2026, 8, 10)),
      ]);

      expect(ordered.map((note) => note.fileName), [
        'nuovo.opus',
        'mezzo.opus',
        'vecchio.opus',
      ]);
    });

    test('dentro la giornata usa il progressivo del nome file', () {
      final day = DateTime(2026, 8, 11);
      final ordered = newestFirst([
        fakeNote(fileName: 'a.opus', nameDay: day, sequence: 1),
        fakeNote(fileName: 'c.opus', nameDay: day, sequence: 9),
        fakeNote(fileName: 'b.opus', nameDay: day, sequence: 4),
      ]);

      expect(ordered.map((note) => note.fileName), [
        'c.opus',
        'b.opus',
        'a.opus',
      ]);
    });

    test('il progressivo vince su una data di modifica riscritta', () {
      // Dopo un ripristino da backup tutti i file hanno quasi lo stesso
      // `receivedAt`: senza il progressivo l'ordine sarebbe arbitrario.
      final day = DateTime(2026, 8, 11);
      final ordered = newestFirst([
        fakeNote(
          fileName: 'primo.opus',
          receivedAt: DateTime(2026, 9, 1, 12, 0, 5),
          nameDay: day,
          sequence: 1,
        ),
        fakeNote(
          fileName: 'secondo.opus',
          receivedAt: DateTime(2026, 9, 1, 12, 0, 1),
          nameDay: day,
          sequence: 2,
        ),
      ]);

      expect(ordered.first.fileName, 'secondo.opus');
    });

    test('non modifica la lista di partenza', () {
      final notes = [
        fakeNote(fileName: 'a.opus', receivedAt: DateTime(2026, 8, 1)),
        fakeNote(fileName: 'b.opus', receivedAt: DateTime(2026, 8, 20)),
      ];
      newestFirst(notes);

      expect(notes.first.fileName, 'a.opus');
    });
  });
}
