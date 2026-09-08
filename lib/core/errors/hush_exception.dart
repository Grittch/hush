sealed class HushException implements Exception {
  const HushException();
}

final class SourceAccessLostException extends HushException {
  const SourceAccessLostException();
}

final class VoiceNoteGoneException extends HushException {
  const VoiceNoteGoneException();
}

final class VoiceNoteUnplayableException extends HushException {
  const VoiceNoteUnplayableException();
}

final class InsufficientStorageException extends HushException {
  const InsufficientStorageException();
}

final class LocalStoreException extends HushException {
  const LocalStoreException();
}

final class UnknownHushException extends HushException {
  const UnknownHushException();
}
