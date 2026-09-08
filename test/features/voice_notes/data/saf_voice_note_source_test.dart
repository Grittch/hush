import 'package:flutter_test/flutter_test.dart';
import 'package:hush/core/errors/hush_exception.dart';
import 'package:hush/features/voice_notes/data/saf_voice_note_source.dart';
import 'package:hush/features/voice_notes/data/voice_note_cache.dart';
import 'package:saf_util/saf_util_platform_interface.dart';

import '../../../support/fake_saf.dart';

const _root = 'content://tree/root';

SafVoiceNoteSource sourceFor(FakeSafUtil safUtil) => SafVoiceNoteSource(
  safUtil,
  FakeSafStream(),
  VoiceNoteCache(),
  folderUri: _root,
);

/// Catena di cartelle annidate con un vocale in fondo, per misurare il budget
/// di profondita della scansione.
Map<String, List<SafDocumentFile>> nested(int depth) {
  final tree = <String, List<SafDocumentFile>>{};
  for (var level = 0; level < depth; level++) {
    final here = level == 0 ? _root : 'content://tree/level$level';
    tree[here] = [safDir('content://tree/level${level + 1}', 'level$level')];
  }
  tree['content://tree/level$depth'] = [
    safFile('content://doc/deep', 'PTT-20260811-WA0001.opus'),
  ];
  return tree;
}

void main() {
  test('trova i vocali nelle sottocartelle per data', () async {
    final safUtil = FakeSafUtil({
      _root: [safDir('content://tree/202608', '202608')],
      'content://tree/202608': [
        safFile('content://doc/1', 'PTT-20260811-WA0001.opus'),
        safFile('content://doc/2', 'PTT-20260812-WA0002.opus'),
        safFile('content://doc/3', '.nomedia'),
      ],
    });

    final notes = await sourceFor(safUtil).listNotes();

    expect(notes.map((note) => note.fileName), [
      'PTT-20260811-WA0001.opus',
      'PTT-20260812-WA0002.opus',
    ]);
    expect(notes.first.nameDay, DateTime(2026, 8, 11));
    expect(notes.first.sequence, 1);
  });

  test('interroga le cartelle di uno stesso livello in parallelo', () async {
    // E la differenza fra un'apertura immediata e qualche secondo di attesa:
    // una cartella con anni di vocali ha un centinaio di sottocartelle.
    final safUtil = FakeSafUtil({
      _root: [
        for (var week = 1; week <= 20; week++)
          safDir('content://tree/w$week', '2026$week'),
      ],
      for (var week = 1; week <= 20; week++)
        'content://tree/w$week': [
          safFile('content://doc/$week', 'PTT-2026081$week-WA000$week.opus'),
        ],
    });

    await sourceFor(safUtil).listNotes();

    expect(safUtil.maxConcurrentLists, greaterThan(1));
  });

  test('scende fino al limite di profondita', () async {
    final safUtil = FakeSafUtil(nested(6));

    final notes = await sourceFor(safUtil).listNotes();

    expect(notes, hasLength(1));
  });

  test('oltre il limite di profondita si ferma senza errori', () async {
    final safUtil = FakeSafUtil(nested(9));

    final notes = await sourceFor(safUtil).listNotes();

    expect(notes, isEmpty);
  });

  test('ignora un vocale ancora in scaricamento', () async {
    // La dimensione fa parte dell'identita: elencarlo ora creerebbe una
    // seconda voce quando il download finisce.
    final safUtil = FakeSafUtil({
      _root: [
        safFile(
          'content://doc/in-corso',
          'PTT-20260811-WA0009.opus',
          lastModified: DateTime.now(),
        ),
        safFile('content://doc/finito', 'PTT-20260811-WA0001.opus'),
      ],
    });

    final notes = await sourceFor(safUtil).listNotes();

    expect(notes.map((note) => note.fileName), ['PTT-20260811-WA0001.opus']);
  });

  test('senza permesso persistente segnala accesso perduto', () async {
    final safUtil = FakeSafUtil({}, hasPermission: false);

    expect(
      sourceFor(safUtil).listNotes(),
      throwsA(isA<SourceAccessLostException>()),
    );
  });

  test('un errore di lettura senza permesso diventa accesso perduto', () async {
    // Il permesso puo cadere durante la scansione: lo stato osservabile
    // decide, non la stringa dell'errore.
    final safUtil = _FailingSafUtil();

    expect(
      sourceFor(safUtil).listNotes(),
      throwsA(isA<SourceAccessLostException>()),
    );
  });
}

/// Il permesso risulta valido al controllo iniziale e caduto quando si legge.
class _FailingSafUtil extends FakeSafUtil {
  _FailingSafUtil() : super({});

  @override
  Future<bool> hasPersistedPermission(
    String uri, {
    bool checkRead = true,
    bool checkWrite = false,
  }) async => hasPermission;

  @override
  Future<List<SafDocumentFile>> list(String uri) async {
    hasPermission = false;
    throw safFailure('boom');
  }
}
