import 'dart:async';

import 'package:hush/core/errors/hush_exception.dart';
import 'package:hush/features/voice_notes/domain/playback_state_store.dart';
import 'package:hush/features/voice_notes/domain/voice_note.dart';
import 'package:hush/features/voice_notes/domain/voice_note_duration_reader.dart';
import 'package:hush/features/voice_notes/domain/voice_note_player.dart';
import 'package:hush/features/voice_notes/domain/voice_note_source.dart';

VoiceNote fakeNote({
  String fileName = 'PTT-20260811-WA0001.opus',
  int sizeBytes = 4096,
  DateTime? receivedAt,
  DateTime? nameDay,
  int? sequence,
  PlaybackProgress? progress,
}) {
  return VoiceNote(
    id: VoiceNoteId(fileName: fileName, sizeBytes: sizeBytes),
    sourceUri: 'content://tree/$fileName',
    receivedAt: receivedAt ?? DateTime(2026, 8, 11, 10, 30),
    nameDay: nameDay,
    sequence: sequence,
    progress: progress,
  );
}

class FakeVoiceNoteSource implements VoiceNoteSource {
  FakeVoiceNoteSource({this.notes = const [], this.materializeDelay});

  List<VoiceNote> notes;
  Duration? materializeDelay;
  HushException? materializeError;
  final List<VoiceNoteId> materialized = [];

  @override
  Future<List<VoiceNote>> listNotes() async => notes;

  @override
  Future<String> materialize(VoiceNote note) async {
    final delay = materializeDelay;
    if (delay != null) await Future<void>.delayed(delay);
    final error = materializeError;
    if (error != null) throw error;
    materialized.add(note.id);
    return '/cache/${note.fileName}';
  }
}

class FakeVoiceNotePlayer implements VoiceNotePlayer {
  final _position = StreamController<Duration>.broadcast();
  final _playing = StreamController<bool>.broadcast();
  final _completion = StreamController<void>.broadcast();

  final List<String> loadedPaths = [];
  final List<String> loadedMediaIds = [];
  Duration? reportedDuration = const Duration(seconds: 30);
  double speed = 1;
  Duration lastSeek = Duration.zero;
  int playCalls = 0;
  int pauseCalls = 0;
  int stopCalls = 0;

  @override
  Stream<Duration> get positionStream => _position.stream;

  @override
  Stream<bool> get playingStream => _playing.stream;

  @override
  Stream<void> get completionStream => _completion.stream;

  void emitPosition(Duration position) => _position.add(position);

  void emitPlaying(bool playing) => _playing.add(playing);

  void emitCompletion() => _completion.add(null);

  Future<void> dispose() async {
    await _position.close();
    await _playing.close();
    await _completion.close();
  }

  @override
  Future<Duration?> load({
    required String path,
    required String mediaId,
    required String title,
    Duration? duration,
  }) async {
    loadedPaths.add(path);
    loadedMediaIds.add(mediaId);
    return reportedDuration;
  }

  @override
  Future<void> play() async => playCalls++;

  @override
  Future<void> pause() async => pauseCalls++;

  @override
  Future<void> seek(Duration position) async => lastSeek = position;

  @override
  Future<void> setSpeed(double value) async => speed = value;

  @override
  Future<void> stop() async => stopCalls++;
}

class FakeDurationReader implements VoiceNoteDurationReader {
  FakeDurationReader({this.duration = const Duration(seconds: 12)});

  Duration? duration;
  HushException? error;
  final List<String> readPaths = [];

  @override
  Future<Duration?> read(String path) async {
    readPaths.add(path);
    final failure = error;
    if (failure != null) throw failure;
    return duration;
  }
}

class RecordingPlaybackStateStore implements PlaybackStateStore {
  final _progress = <VoiceNoteId, PlaybackProgress>{};
  final _controller =
      StreamController<Map<VoiceNoteId, PlaybackProgress>>.broadcast();
  final List<VoiceNoteId> played = [];
  final List<({VoiceNoteId id, Duration position})> saved = [];
  final List<({VoiceNoteId id, Duration duration})> durationsSaved = [];
  final List<VoiceNoteId> unavailableMarked = [];

  Map<VoiceNoteId, PlaybackProgress> get current => Map.unmodifiable(_progress);

  Future<void> dispose() => _controller.close();

  @override
  Stream<Map<VoiceNoteId, PlaybackProgress>> watchAll() => _controller.stream;

  @override
  Future<Map<VoiceNoteId, PlaybackProgress>> readAll() async => current;

  @override
  Future<void> saveProgress({
    required VoiceNoteId id,
    required Duration position,
    Duration? duration,
  }) async {
    saved.add((id: id, position: position));
    _progress[id] = PlaybackProgress(
      position: position,
      duration: duration,
      playedAt: _progress[id]?.playedAt,
    );
  }

  @override
  Future<void> saveDuration({
    required VoiceNoteId id,
    required Duration duration,
  }) async {
    durationsSaved.add((id: id, duration: duration));
    final existing = _progress[id];
    _progress[id] = PlaybackProgress(
      position: existing?.position ?? Duration.zero,
      duration: duration,
      playedAt: existing?.playedAt,
    );
  }

  @override
  Future<void> markDurationUnavailable(VoiceNoteId id) async {
    unavailableMarked.add(id);
    final existing = _progress[id];
    _progress[id] = PlaybackProgress(
      position: existing?.position ?? Duration.zero,
      duration: existing?.duration,
      playedAt: existing?.playedAt,
      durationUnavailable: true,
    );
  }

  @override
  Future<void> markPlayed(VoiceNoteId id) async {
    played.add(id);
    final existing = _progress[id];
    _progress[id] = PlaybackProgress(
      position: Duration.zero,
      duration: existing?.duration,
      playedAt: DateTime(2026, 8, 11),
      durationUnavailable: existing?.durationUnavailable ?? false,
    );
  }
}
