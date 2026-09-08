import 'package:flutter_test/flutter_test.dart';
import 'package:hush/features/voice_notes/data/voice_note_file_name.dart';

void main() {
  group('isAudioFileName', () {
    test('accetta le estensioni che WhatsApp produce', () {
      expect(isAudioFileName('PTT-20260811-WA0001.opus'), isTrue);
      expect(isAudioFileName('PTT-20200704-WA0002.ogg'), isTrue);
    });

    test('rifiuta cio che non e audio', () {
      expect(isAudioFileName('.nomedia'), isFalse);
      expect(isAudioFileName('IMG-20260811-WA0003.jpg'), isFalse);
      expect(isAudioFileName('senza_estensione'), isFalse);
    });

    test('ignora la differenza di maiuscole', () {
      expect(isAudioFileName('PTT-20260811-WA0001.OPUS'), isTrue);
    });
  });

  group('dayFromFileName', () {
    test('estrae il giorno dallo schema di WhatsApp', () {
      expect(
        dayFromFileName('PTT-20260811-WA0001.opus'),
        DateTime(2026, 8, 11),
      );
    });

    test('restituisce null per un nome fuori schema', () {
      expect(dayFromFileName('registrazione.opus'), isNull);
      expect(dayFromFileName('AUD-20260811-WA0001.opus'), isNull);
      expect(dayFromFileName('PTT-2026811-WA0001.opus'), isNull);
    });

    test('restituisce null per una data impossibile', () {
      expect(dayFromFileName('PTT-20261301-WA0001.opus'), isNull);
      expect(dayFromFileName('PTT-20260230-WA0001.opus'), isNull);
    });

    test('non si fa ingannare da un nome che comincia bene', () {
      expect(dayFromFileName('PTT-20260811-WA0001'), isNull);
    });
  });
}
