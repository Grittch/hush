import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../../../core/errors/hush_exception_mapper.dart';
import '../domain/voice_note_player.dart';

class HushAudioHandler extends BaseAudioHandler
    with SeekHandler
    implements VoiceNotePlayer {
  HushAudioHandler() {
    _player.playbackEventStream.listen(_broadcast);
  }

  final AudioPlayer _player = AudioPlayer();

  @override
  Stream<Duration> get positionStream => _player.positionStream;

  @override
  Stream<bool> get playingStream => _player.playingStream;

  @override
  Stream<void> get completionStream => _player.processingStateStream.where(
    (state) => state == ProcessingState.completed,
  );

  @override
  Future<Duration?> load({
    required String path,
    required String mediaId,
    required String title,
    Duration? duration,
  }) {
    return mapErrors(() async {
      mediaItem.add(MediaItem(id: mediaId, title: title, duration: duration));
      return _player.setFilePath(path);
    });
  }

  @override
  Future<void> play() => mapErrors(_player.play);

  @override
  Future<void> pause() => mapErrors(_player.pause);

  @override
  Future<void> seek(Duration position) =>
      mapErrors(() => _player.seek(position));

  @override
  Future<void> setSpeed(double speed) =>
      mapErrors(() => _player.setSpeed(speed));

  @override
  Future<void> stop() async {
    await mapErrors(_player.stop);
    await super.stop();
  }

  /// Senza questo il servizio in foreground resta vivo dopo che l'utente ha
  /// chiuso l'app dai recenti, con la notifica appesa.
  @override
  Future<void> onTaskRemoved() => stop();

  void _broadcast(PlaybackEvent event) {
    final playing = _player.playing;
    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          MediaControl.rewind,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.fastForward,
          MediaControl.stop,
        ],
        systemActions: const {MediaAction.seek},
        androidCompactActionIndices: const [0, 1, 2],
        processingState: _processingState(event.processingState),
        playing: playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
      ),
    );
  }

  AudioProcessingState _processingState(ProcessingState state) {
    return switch (state) {
      ProcessingState.idle => AudioProcessingState.idle,
      ProcessingState.loading => AudioProcessingState.loading,
      ProcessingState.buffering => AudioProcessingState.buffering,
      ProcessingState.ready => AudioProcessingState.ready,
      ProcessingState.completed => AudioProcessingState.completed,
    };
  }
}
