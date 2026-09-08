import 'package:just_audio/just_audio.dart';

import '../../../core/errors/hush_exception_mapper.dart';
import '../domain/voice_note_duration_reader.dart';

/// Usa un player separato da quello dell'ascolto: caricare una traccia per
/// misurarla sull'istanza in riproduzione interromperebbe il vocale che
/// l'utente sta sentendo.
class JustAudioDurationReader implements VoiceNoteDurationReader {
  AudioPlayer? _player;

  @override
  Future<Duration?> read(String path) {
    return mapErrors(() async {
      final player = _player ??= AudioPlayer();
      return player.setFilePath(path);
    });
  }

  Future<void> dispose() async {
    await _player?.dispose();
    _player = null;
  }
}
