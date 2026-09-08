abstract interface class VoiceNoteDurationReader {
  /// Legge la durata di un file locale senza avviare la riproduzione.
  Future<Duration?> read(String path);
}
