import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Hush'**
  String get appTitle;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Listen without opening WhatsApp'**
  String get onboardingTitle;

  /// No description provided for @onboardingBody.
  ///
  /// In en, this message translates to:
  /// **'Pick the folder where WhatsApp keeps received voice notes. Hush only reads it: nothing is modified, and the sender is never told you listened.'**
  String get onboardingBody;

  /// No description provided for @onboardingHint.
  ///
  /// In en, this message translates to:
  /// **'It is usually Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Voice Notes, but the path changes between phones.'**
  String get onboardingHint;

  /// No description provided for @onboardingChooseFolder.
  ///
  /// In en, this message translates to:
  /// **'Choose folder'**
  String get onboardingChooseFolder;

  /// No description provided for @listEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No voice notes here'**
  String get listEmptyTitle;

  /// No description provided for @listEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'No audio files were found in the folder you picked. If you chose a folder higher up, try picking the WhatsApp Voice Notes folder itself.'**
  String get listEmptyBody;

  /// No description provided for @listRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get listRefresh;

  /// No description provided for @accessLostTitle.
  ///
  /// In en, this message translates to:
  /// **'Access to the folder was lost'**
  String get accessLostTitle;

  /// No description provided for @accessLostBody.
  ///
  /// In en, this message translates to:
  /// **'The permission was revoked, or the folder is no longer reachable. Pick it again to keep listening.'**
  String get accessLostBody;

  /// No description provided for @chooseFolderAgain.
  ///
  /// In en, this message translates to:
  /// **'Pick the folder again'**
  String get chooseFolderAgain;

  /// No description provided for @errorNoteGone.
  ///
  /// In en, this message translates to:
  /// **'This voice note is no longer in the folder.'**
  String get errorNoteGone;

  /// No description provided for @errorNoteUnplayable.
  ///
  /// In en, this message translates to:
  /// **'This voice note cannot be played.'**
  String get errorNoteUnplayable;

  /// No description provided for @errorInsufficientStorage.
  ///
  /// In en, this message translates to:
  /// **'Not enough space to prepare this voice note.'**
  String get errorInsufficientStorage;

  /// No description provided for @errorLocalStore.
  ///
  /// In en, this message translates to:
  /// **'Could not read the saved listening state.'**
  String get errorLocalStore;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get errorUnknown;

  /// No description provided for @actionRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get actionRetry;

  /// No description provided for @badgeUnplayed.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get badgeUnplayed;

  /// No description provided for @playerPlay.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get playerPlay;

  /// No description provided for @playerPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get playerPause;

  /// No description provided for @playerSkipBack.
  ///
  /// In en, this message translates to:
  /// **'Back {seconds} seconds'**
  String playerSkipBack(int seconds);

  /// No description provided for @playerSkipForward.
  ///
  /// In en, this message translates to:
  /// **'Forward {seconds} seconds'**
  String playerSkipForward(int seconds);

  /// No description provided for @playerSpeed.
  ///
  /// In en, this message translates to:
  /// **'Playback speed'**
  String get playerSpeed;

  /// No description provided for @playerSpeedValue.
  ///
  /// In en, this message translates to:
  /// **'{speed}×'**
  String playerSpeedValue(String speed);

  /// No description provided for @durationUnknown.
  ///
  /// In en, this message translates to:
  /// **'--:--'**
  String get durationUnknown;

  /// No description provided for @groupToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get groupToday;

  /// No description provided for @groupYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get groupYesterday;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSourceFolder.
  ///
  /// In en, this message translates to:
  /// **'Source folder'**
  String get settingsSourceFolder;

  /// No description provided for @settingsChangeFolder.
  ///
  /// In en, this message translates to:
  /// **'Change folder'**
  String get settingsChangeFolder;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow system'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow system'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsLanguageItalian.
  ///
  /// In en, this message translates to:
  /// **'Italiano'**
  String get settingsLanguageItalian;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @timeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Time unknown'**
  String get timeUnknown;

  /// No description provided for @notificationsBlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Playback controls are off'**
  String get notificationsBlockedTitle;

  /// No description provided for @notificationsBlockedBody.
  ///
  /// In en, this message translates to:
  /// **'Without notification permission the audio still plays, but there are no controls outside the app.'**
  String get notificationsBlockedBody;

  /// No description provided for @openSystemSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSystemSettings;

  /// No description provided for @voiceNoteSemanticLabel.
  ///
  /// In en, this message translates to:
  /// **'Voice note, {time}, lasting {duration}'**
  String voiceNoteSemanticLabel(String time, String duration);

  /// No description provided for @playerProgressLabel.
  ///
  /// In en, this message translates to:
  /// **'Position: {position}'**
  String playerProgressLabel(String position);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
