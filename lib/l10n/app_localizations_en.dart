// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Hush';

  @override
  String get onboardingTitle => 'Listen without opening WhatsApp';

  @override
  String get onboardingBody =>
      'Pick the folder where WhatsApp keeps received voice notes. Hush only reads it: nothing is modified, and the sender is never told you listened.';

  @override
  String get onboardingHint =>
      'It is usually Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Voice Notes, but the path changes between phones.';

  @override
  String get onboardingChooseFolder => 'Choose folder';

  @override
  String get listEmptyTitle => 'No voice notes here';

  @override
  String get listEmptyBody =>
      'No audio files were found in the folder you picked. If you chose a folder higher up, try picking the WhatsApp Voice Notes folder itself.';

  @override
  String get listRefresh => 'Refresh';

  @override
  String get accessLostTitle => 'Access to the folder was lost';

  @override
  String get accessLostBody =>
      'The permission was revoked, or the folder is no longer reachable. Pick it again to keep listening.';

  @override
  String get chooseFolderAgain => 'Pick the folder again';

  @override
  String get errorNoteGone => 'This voice note is no longer in the folder.';

  @override
  String get errorNoteUnplayable => 'This voice note cannot be played.';

  @override
  String get errorInsufficientStorage =>
      'Not enough space to prepare this voice note.';

  @override
  String get errorLocalStore => 'Could not read the saved listening state.';

  @override
  String get errorUnknown => 'Something went wrong.';

  @override
  String get actionRetry => 'Retry';

  @override
  String get badgeUnplayed => 'New';

  @override
  String get playerPlay => 'Play';

  @override
  String get playerPause => 'Pause';

  @override
  String playerSkipBack(int seconds) {
    return 'Back $seconds seconds';
  }

  @override
  String playerSkipForward(int seconds) {
    return 'Forward $seconds seconds';
  }

  @override
  String get playerSpeed => 'Playback speed';

  @override
  String playerSpeedValue(String speed) {
    return '$speed×';
  }

  @override
  String get durationUnknown => '--:--';

  @override
  String get groupToday => 'Today';

  @override
  String get groupYesterday => 'Yesterday';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSourceFolder => 'Source folder';

  @override
  String get settingsChangeFolder => 'Change folder';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsThemeSystem => 'Follow system';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'Follow system';

  @override
  String get settingsLanguageItalian => 'Italiano';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get timeUnknown => 'Time unknown';

  @override
  String get notificationsBlockedTitle => 'Playback controls are off';

  @override
  String get notificationsBlockedBody =>
      'Without notification permission the audio still plays, but there are no controls outside the app.';

  @override
  String get openSystemSettings => 'Open settings';

  @override
  String voiceNoteSemanticLabel(String time, String duration) {
    return 'Voice note, $time, lasting $duration';
  }

  @override
  String playerProgressLabel(String position) {
    return 'Position: $position';
  }
}
