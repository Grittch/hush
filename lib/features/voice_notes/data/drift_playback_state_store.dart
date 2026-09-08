import 'dart:async';

import 'package:drift/drift.dart';

import '../../../core/errors/hush_exception.dart';
import '../../../core/errors/hush_exception_mapper.dart';
import '../domain/playback_state_store.dart';
import '../domain/voice_note.dart';
import 'hush_database.dart';

class DriftPlaybackStateStore implements PlaybackStateStore {
  DriftPlaybackStateStore(this._database);

  final HushDatabase _database;

  @override
  Stream<Map<VoiceNoteId, PlaybackProgress>> watchAll() {
    return _database
        .select(_database.playbackStates)
        .watch()
        .map(_toProgressMap)
        .transform(
          StreamTransformer.fromHandlers(
            handleError: (error, stackTrace, sink) =>
                sink.addError(const LocalStoreException(), stackTrace),
          ),
        );
  }

  @override
  Future<Map<VoiceNoteId, PlaybackProgress>> readAll() => _guard(
    () async =>
        _toProgressMap(await _database.select(_database.playbackStates).get()),
  );

  @override
  Future<void> saveProgress({
    required VoiceNoteId id,
    required Duration position,
    Duration? duration,
  }) {
    return _guard(
      () => _database
          .into(_database.playbackStates)
          .insertOnConflictUpdate(
            PlaybackStatesCompanion.insert(
              fileName: id.fileName,
              sizeBytes: id.sizeBytes,
              positionMs: Value(position.inMilliseconds),
              // `Value(null)` sovrascriverebbe con NULL una durata gia
              // misurata: qui la colonna deve restare assente.
              durationMs: Value.absentIfNull(duration?.inMilliseconds),
            ),
          ),
    );
  }

  @override
  Future<void> saveDuration({
    required VoiceNoteId id,
    required Duration duration,
  }) {
    return _guard(
      () => _database
          .into(_database.playbackStates)
          .insertOnConflictUpdate(
            PlaybackStatesCompanion.insert(
              fileName: id.fileName,
              sizeBytes: id.sizeBytes,
              durationMs: Value(duration.inMilliseconds),
            ),
          ),
    );
  }

  @override
  Future<void> markDurationUnavailable(VoiceNoteId id) {
    return _guard(
      () => _database
          .into(_database.playbackStates)
          .insertOnConflictUpdate(
            PlaybackStatesCompanion.insert(
              fileName: id.fileName,
              sizeBytes: id.sizeBytes,
              durationUnavailable: const Value(true),
            ),
          ),
    );
  }

  @override
  Future<void> markPlayed(VoiceNoteId id) {
    return _guard(
      () => _database
          .into(_database.playbackStates)
          .insertOnConflictUpdate(
            PlaybackStatesCompanion.insert(
              fileName: id.fileName,
              sizeBytes: id.sizeBytes,
              positionMs: const Value(0),
              playedAt: Value(DateTime.now()),
            ),
          ),
    );
  }

  Map<VoiceNoteId, PlaybackProgress> _toProgressMap(List<PlaybackState> rows) {
    return {
      for (final row in rows)
        VoiceNoteId(fileName: row.fileName, sizeBytes: row.sizeBytes):
            _toProgress(row),
    };
  }

  PlaybackProgress _toProgress(PlaybackState row) {
    final durationMs = row.durationMs;
    return PlaybackProgress(
      position: Duration(milliseconds: row.positionMs),
      duration: durationMs == null ? null : Duration(milliseconds: durationMs),
      playedAt: row.playedAt,
      durationUnavailable: row.durationUnavailable,
    );
  }

  /// Il mapper condiviso riconosce le eccezioni di libreria; quello che non
  /// riconosce, qui dentro, e comunque un guasto dello store locale: e questo
  /// il posto che lo sa, non il mapper.
  Future<T> _guard<T>(Future<T> Function() operation) async {
    try {
      return await mapErrors(operation);
    } on UnknownHushException {
      throw const LocalStoreException();
    }
  }
}
