extension DurationClock on Duration {
  String get asClock {
    final totalSeconds = inSeconds;
    final minutes = (totalSeconds ~/ 60) % 60;
    final seconds = totalSeconds % 60;
    final twoDigitSeconds = seconds.toString().padLeft(2, '0');
    if (inHours == 0) {
      return '$minutes:$twoDigitSeconds';
    }
    return '$inHours:${minutes.toString().padLeft(2, '0')}:$twoDigitSeconds';
  }
}
