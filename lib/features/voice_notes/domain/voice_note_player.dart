abstract interface class VoiceNotePlayer {
  Stream<Duration> get positionStream;

  Stream<bool> get playingStream;

  /// Emette quando la traccia corrente arriva alla fine.
  Stream<void> get completionStream;

  Future<Duration?> load({
    required String path,
    required String mediaId,
    required String title,
    Duration? duration,
  });

  Future<void> play();

  Future<void> pause();

  Future<void> seek(Duration position);

  Future<void> setSpeed(double speed);

  Future<void> stop();
}
