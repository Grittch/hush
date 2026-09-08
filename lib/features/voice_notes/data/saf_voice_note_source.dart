import 'package:saf_stream/saf_stream.dart';
import 'package:saf_util/saf_util.dart';
import 'package:saf_util/saf_util_platform_interface.dart';

import '../../../core/errors/hush_exception.dart';
import '../../../core/errors/hush_exception_mapper.dart';
import '../domain/voice_note.dart';
import '../domain/voice_note_source.dart';
import 'voice_note_cache.dart';
import 'voice_note_file_name.dart';

/// L'utente puo scegliere una cartella piu in alto del previsto (la radice di
/// `Android/media`, o la memoria interna): il budget deve arrivare comunque
/// alle sottocartelle per data di WhatsApp.
const _maxFolderDepth = 6;

/// Un vocale ancora in download ha una dimensione parziale, e la dimensione fa
/// parte della sua identita: elencarlo adesso creerebbe una seconda voce
/// quando il download finisce.
const _settleTime = Duration(seconds: 5);

/// Quante cartelle interrogare insieme.
const _listBatchSize = 8;

class SafVoiceNoteSource implements VoiceNoteSource {
  SafVoiceNoteSource(
    this._safUtil,
    this._safStream,
    this._cache, {
    required this.folderUri,
  });

  final String folderUri;
  final SafUtil _safUtil;
  final SafStream _safStream;
  final VoiceNoteCache _cache;

  @override
  Future<List<VoiceNote>> listNotes() {
    return _withAccessCheck(() async {
      if (!await _hasAccess()) throw const SourceAccessLostException();

      final notes = <VoiceNote>[];
      final settledBefore = DateTime.now().subtract(_settleTime);
      var frontier = <String>[folderUri];

      for (
        var depth = 0;
        depth <= _maxFolderDepth && frontier.isNotEmpty;
        depth++
      ) {
        final deeper = <String>[];
        for (final child in await _listChildren(frontier)) {
          if (child.isDir) {
            deeper.add(child.uri);
            continue;
          }
          if (!isAudioFileName(child.name)) continue;
          final note = _toVoiceNote(child);
          if (note.receivedAt.isAfter(settledBefore)) continue;
          notes.add(note);
        }
        frontier = deeper;
      }
      return notes;
    });
  }

  @override
  Future<String> materialize(VoiceNote note) {
    return _withAccessCheck(() async {
      final file = await _cache.fileFor(note.id);
      final cached =
          file.existsSync() && await file.length() == note.id.sizeBytes;
      if (cached) {
        await _cache.touch(file);
      } else {
        await _safStream.copyToLocalFile(note.sourceUri, file.path);
        await _cache.registerCopy(file, keepPath: file.path);
      }
      return file.path;
    });
  }

  /// Interroga piu cartelle insieme. Ogni `list` lato nativo gira su
  /// `Dispatchers.IO`, quindi le chiamate concorrenti si sovrappongono
  /// davvero: e la differenza fra un'apertura immediata e qualche secondo di
  /// attesa, perche una cartella con anni di vocali ha un centinaio di
  /// sottocartelle settimanali. Il gruppo e limitato per non aprire un
  /// centinaio di query insieme.
  Future<List<SafDocumentFile>> _listChildren(List<String> directories) async {
    final children = <SafDocumentFile>[];
    for (var start = 0; start < directories.length; start += _listBatchSize) {
      final batch = directories.skip(start).take(_listBatchSize);
      for (final result in await Future.wait(batch.map(_safUtil.list))) {
        children.addAll(result);
      }
    }
    return children;
  }

  /// Il permesso persistente puo cadere in qualunque momento, e i plugin SAF
  /// riportano tutto come `PlatformException` generica. Invece di indovinare
  /// dal messaggio, davanti a un errore non riconosciuto si interroga lo stato
  /// reale del permesso.
  Future<T> _withAccessCheck<T>(Future<T> Function() operation) async {
    try {
      return await mapErrors(operation);
    } on UnknownHushException {
      if (!await _hasAccess()) throw const SourceAccessLostException();
      rethrow;
    }
  }

  Future<bool> _hasAccess() async {
    try {
      return await _safUtil.hasPersistedPermission(folderUri, checkRead: true);
    } on Exception {
      return false;
    }
  }

  VoiceNote _toVoiceNote(SafDocumentFile file) {
    return VoiceNote(
      id: VoiceNoteId(fileName: file.name, sizeBytes: file.length),
      sourceUri: file.uri,
      receivedAt: DateTime.fromMillisecondsSinceEpoch(file.lastModified),
      nameDay: dayFromFileName(file.name),
      sequence: sequenceFromFileName(file.name),
    );
  }
}
