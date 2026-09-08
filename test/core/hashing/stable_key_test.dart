import 'package:flutter_test/flutter_test.dart';
import 'package:hush/core/hashing/stable_key.dart';
import 'package:hush/features/voice_notes/domain/voice_note.dart';

void main() {
  group('stableKey', () {
    test('e stabile per lo stesso input', () {
      expect(stableKey('a|1'), stableKey('a|1'));
    });

    test('non contiene il testo di partenza', () {
      expect(
        stableKey('PTT-20260811-WA0001.opus|4096'),
        isNot(contains('PTT')),
      );
    });

    test('produce un nome usabile come file', () {
      expect(stableKey('Registrazione 1.opus|5000'), matches(r'^[0-9a-f]+$'));
    });

    test('distingue nomi che una sostituzione lossy farebbe collidere', () {
      // `Registrazione 1.opus` e `Registrazione_1.opus` con la stessa
      // dimensione finivano nello stesso file di cache, e si sentiva il
      // vocale sbagliato.
      const withSpace = VoiceNoteId(
        fileName: 'Registrazione 1.opus',
        sizeBytes: 5000,
      );
      const withUnderscore = VoiceNoteId(
        fileName: 'Registrazione_1.opus',
        sizeBytes: 5000,
      );

      expect(
        stableKey(withSpace.storageKey),
        isNot(stableKey(withUnderscore.storageKey)),
      );
    });

    test('distingue lo stesso nome con dimensioni diverse', () {
      expect(stableKey('a.opus|100'), isNot(stableKey('a.opus|200')));
    });
  });
}
