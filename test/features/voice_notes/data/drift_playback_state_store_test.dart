import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hush/core/errors/hush_exception.dart';
import 'package:hush/features/voice_notes/data/drift_playback_state_store.dart';
import 'package:hush/features/voice_notes/data/hush_database.dart';
import 'package:hush/features/voice_notes/domain/voice_note.dart';

void main() {
  late HushDatabase database;
  late DriftPlaybackStateStore store;

  const id = VoiceNoteId(fileName: 'PTT-20260811-WA0001.opus', sizeBytes: 4096);

  setUp(() {
    database = HushDatabase.withExecutor(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
    store = DriftPlaybackStateStore(database);
  });

  tearDown(() => database.close());

  test('parte senza stato salvato', () async {
    expect(await store.watchAll().first, isEmpty);
  });

  test('salva e rilegge la posizione di ripresa', () async {
    await store.saveProgress(
      id: id,
      position: const Duration(seconds: 12),
      duration: const Duration(seconds: 45),
    );

    final progress = (await store.watchAll().first)[id];
    expect(progress?.position, const Duration(seconds: 12));
    expect(progress?.duration, const Duration(seconds: 45));
    expect(progress?.isPlayed, isFalse);
  });

  test(
    'un secondo salvataggio aggiorna la riga invece di duplicarla',
    () async {
      await store.saveProgress(id: id, position: const Duration(seconds: 3));
      await store.saveProgress(id: id, position: const Duration(seconds: 9));

      final all = await store.watchAll().first;
      expect(all, hasLength(1));
      expect(all[id]?.position, const Duration(seconds: 9));
    },
  );

  test(
    'markPlayed azzera la ripresa e registra quando e stato ascoltato',
    () async {
      await store.saveProgress(id: id, position: const Duration(seconds: 20));
      await store.markPlayed(id);

      final progress = (await store.watchAll().first)[id];
      expect(progress?.isPlayed, isTrue);
      expect(progress?.position, Duration.zero);
      expect(progress?.hasResumePoint, isFalse);
    },
  );

  test('un errore dello store diventa un errore tipizzato', () async {
    // Nessuna eccezione di Drift deve uscire dal data layer: la UI conosce
    // solo gli errori del dominio.
    // Chiudere il database non basta: drift ne riapre uno vuoto in memoria e
    // la scrittura riesce. Serve un guasto vero, e togliere la tabella lo e.
    await database.customStatement('DROP TABLE playback_states;');

    await expectLater(
      store.saveProgress(id: id, position: Duration.zero),
      throwsA(isA<LocalStoreException>()),
    );
    await expectLater(store.readAll(), throwsA(isA<LocalStoreException>()));
  });

  test('readAll restituisce uno snapshot senza aspettare lo stream', () async {
    expect(await store.readAll(), isEmpty);

    await store.saveDuration(id: id, duration: const Duration(seconds: 18));

    expect((await store.readAll())[id]?.duration, const Duration(seconds: 18));
  });

  test('saveDuration non azzera posizione e stato di ascolto', () async {
    await store.saveProgress(id: id, position: const Duration(seconds: 14));
    await store.markPlayed(id);
    await store.saveDuration(id: id, duration: const Duration(seconds: 40));

    final progress = (await store.readAll())[id];
    expect(progress?.duration, const Duration(seconds: 40));
    expect(progress?.isPlayed, isTrue, reason: 'l ascolto resta registrato');
  });

  test('markDurationUnavailable chiude la misura per quel vocale', () async {
    expect((await store.readAll())[id], isNull);

    await store.markDurationUnavailable(id);

    final progress = (await store.readAll())[id];
    expect(progress?.durationUnavailable, isTrue);
    expect(progress?.needsDurationMeasure, isFalse);
    expect(progress?.duration, isNull);
  });

  test('markDurationUnavailable non tocca ascolto e ripresa', () async {
    await store.saveProgress(id: id, position: const Duration(seconds: 8));
    await store.markPlayed(id);
    await store.markDurationUnavailable(id);

    final progress = (await store.readAll())[id];
    expect(progress?.isPlayed, isTrue);
    expect(progress?.durationUnavailable, isTrue);
  });

  test('un vocale senza riga va misurato', () async {
    await store.saveProgress(id: id, position: Duration.zero);

    expect((await store.readAll())[id]?.needsDurationMeasure, isTrue);
  });

  test('saveProgress non cancella una durata gia misurata', () async {
    await store.saveDuration(id: id, duration: const Duration(seconds: 40));
    await store.saveProgress(id: id, position: const Duration(seconds: 2));

    final progress = (await store.readAll())[id];
    expect(progress?.position, const Duration(seconds: 2));
    expect(progress?.duration, const Duration(seconds: 40));
  });

  test('lo stream riflette una scrittura senza essere riletto', () async {
    final emissions = <Map<VoiceNoteId, PlaybackProgress>>[];
    final subscription = store.watchAll().listen(emissions.add);
    await pumpEventQueue();

    await store.saveProgress(id: id, position: const Duration(seconds: 5));
    await pumpEventQueue();
    await subscription.cancel();

    expect(emissions.first, isEmpty);
    expect(emissions.last[id]?.position, const Duration(seconds: 5));
  });

  test(
    'vocali con stesso nome e dimensione diversa hanno righe separate',
    () async {
      const other = VoiceNoteId(
        fileName: 'PTT-20260811-WA0001.opus',
        sizeBytes: 8192,
      );
      await store.saveProgress(id: id, position: const Duration(seconds: 1));
      await store.saveProgress(id: other, position: const Duration(seconds: 2));

      final all = await store.watchAll().first;
      expect(all, hasLength(2));
      expect(all[id]?.position, const Duration(seconds: 1));
      expect(all[other]?.position, const Duration(seconds: 2));
    },
  );
}
