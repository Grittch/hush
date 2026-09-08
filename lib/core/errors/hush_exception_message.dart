import '../../l10n/app_localizations.dart';
import 'hush_exception.dart';

extension HushExceptionMessage on HushException {
  String localized(AppLocalizations l10n) => switch (this) {
    SourceAccessLostException() => l10n.accessLostBody,
    VoiceNoteGoneException() => l10n.errorNoteGone,
    VoiceNoteUnplayableException() => l10n.errorNoteUnplayable,
    InsufficientStorageException() => l10n.errorInsufficientStorage,
    LocalStoreException() => l10n.errorLocalStore,
    UnknownHushException() => l10n.errorUnknown,
  };
}
