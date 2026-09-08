import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hush/features/voice_notes/data/drift_playback_state_store.dart';
import 'package:hush/features/voice_notes/data/hush_database.dart';
import 'package:hush/features/voice_notes/domain/voice_note.dart';

/// Lo schema v1: la tabella prima che `durationUnavailable` esistesse.
const _createV1 = '''
CREATE TABLE playback_states (
  file_name TEXT NOT NULL,
  size_bytes INTEGER NOT NULL,
  position_ms INTEGER NOT NULL DEFAULT 0,
  duration_ms INTEGER NULL,
  played_at INTEGER NULL,
  PRIMARY KEY (file_name, size_bytes)
);
''';

void main() {
  const id = VoiceNoteId(fileName: 'PTT-20260811-WA0001.opus', sizeBytes: 4096);

  test('un database v1 esistente sopravvive alla migrazione', () async {
    // La migrazione gira sui telefoni dove l'app e gia installata: se sbaglia,
    // l'app non si apre e lo stato di ascolto e perduto.
    final database = HushDatabase.withExecutor(
      NativeDatabase.memory(
        setup: (raw) {
          raw.execute(_createV1);
          raw.execute(
            'INSERT INTO playback_states '
            '(file_name, size_bytes, position_ms, duration_ms) '
            "VALUES ('${id.fileName}', ${id.sizeBytes}, 7000, 31000);",
          );
          raw.execute('PRAGMA user_version = 1;');
        },
      ),
    );
    addTearDown(database.close);
    final store = DriftPlaybackStateStore(database);

    final progress = (await store.readAll())[id];

    expect(progress?.position, const Duration(seconds: 7));
    expect(progress?.duration, const Duration(seconds: 31));
    expect(
      progress?.durationUnavailable,
      isFalse,
      reason: 'la colonna nuova parte dal default, non da NULL',
    );
    final stored = await database
        .customSelect('PRAGMA user_version;')
        .getSingle();
    expect(
      stored.data.values.first,
      2,
      reason: 'la versione va scritta nel database, non solo nel codice',
    );
  });

  test('la colonna nuova e scrivibile dopo la migrazione', () async {
    final database = HushDatabase.withExecutor(
      NativeDatabase.memory(
        setup: (raw) {
          raw.execute(_createV1);
          raw.execute('PRAGMA user_version = 1;');
        },
      ),
    );
    addTearDown(database.close);
    final store = DriftPlaybackStateStore(database);

    await store.markDurationUnavailable(id);

    expect((await store.readAll())[id]?.durationUnavailable, isTrue);
  });
}
