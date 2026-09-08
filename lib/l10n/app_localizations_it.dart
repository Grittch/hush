// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Hush';

  @override
  String get onboardingTitle => 'Ascolta senza aprire WhatsApp';

  @override
  String get onboardingBody =>
      'Scegli la cartella dove WhatsApp tiene i vocali ricevuti. Hush la legge e basta: non modifica nulla, e al mittente non arriva alcun segnale che li hai ascoltati.';

  @override
  String get onboardingHint =>
      'Di solito è Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Voice Notes, ma il percorso cambia da telefono a telefono.';

  @override
  String get onboardingChooseFolder => 'Scegli cartella';

  @override
  String get listEmptyTitle => 'Nessun vocale qui';

  @override
  String get listEmptyBody =>
      'Nella cartella che hai scelto non ci sono file audio. Se hai scelto una cartella piu in alto, prova a selezionare direttamente la cartella WhatsApp Voice Notes.';

  @override
  String get listRefresh => 'Aggiorna';

  @override
  String get accessLostTitle => 'Accesso alla cartella perduto';

  @override
  String get accessLostBody =>
      'Il permesso è stato revocato, o la cartella non è più raggiungibile. Riselezionala per continuare ad ascoltare.';

  @override
  String get chooseFolderAgain => 'Riseleziona la cartella';

  @override
  String get errorNoteGone => 'Questo vocale non è più nella cartella.';

  @override
  String get errorNoteUnplayable => 'Questo vocale non può essere riprodotto.';

  @override
  String get errorInsufficientStorage =>
      'Spazio insufficiente per preparare questo vocale.';

  @override
  String get errorLocalStore =>
      'Non è stato possibile leggere lo stato di ascolto salvato.';

  @override
  String get errorUnknown => 'Qualcosa è andato storto.';

  @override
  String get actionRetry => 'Riprova';

  @override
  String get badgeUnplayed => 'Nuovo';

  @override
  String get playerPlay => 'Riproduci';

  @override
  String get playerPause => 'Pausa';

  @override
  String playerSkipBack(int seconds) {
    return 'Indietro di $seconds secondi';
  }

  @override
  String playerSkipForward(int seconds) {
    return 'Avanti di $seconds secondi';
  }

  @override
  String get playerSpeed => 'Velocità di riproduzione';

  @override
  String playerSpeedValue(String speed) {
    return '$speed×';
  }

  @override
  String get durationUnknown => '--:--';

  @override
  String get groupToday => 'Oggi';

  @override
  String get groupYesterday => 'Ieri';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsSourceFolder => 'Cartella sorgente';

  @override
  String get settingsChangeFolder => 'Cambia cartella';

  @override
  String get settingsAppearance => 'Aspetto';

  @override
  String get settingsThemeSystem => 'Come il sistema';

  @override
  String get settingsThemeLight => 'Chiaro';

  @override
  String get settingsThemeDark => 'Scuro';

  @override
  String get settingsLanguage => 'Lingua';

  @override
  String get settingsLanguageSystem => 'Come il sistema';

  @override
  String get settingsLanguageItalian => 'Italiano';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get timeUnknown => 'Orario non disponibile';

  @override
  String get notificationsBlockedTitle =>
      'Controlli di riproduzione disattivati';

  @override
  String get notificationsBlockedBody =>
      'Senza il permesso per le notifiche l\'audio si sente comunque, ma non ci sono controlli fuori dall\'app.';

  @override
  String get openSystemSettings => 'Apri impostazioni';

  @override
  String voiceNoteSemanticLabel(String time, String duration) {
    return 'Vocale, $time, durata $duration';
  }

  @override
  String playerProgressLabel(String position) {
    return 'Posizione: $position';
  }
}
