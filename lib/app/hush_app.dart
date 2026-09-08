import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/settings/app_settings.dart';
import '../core/settings/app_settings_controller.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/voice_notes/presentation/voice_notes_screen.dart';
import '../l10n/app_localizations.dart';
import 'theme.dart';

class HushApp extends ConsumerWidget {
  const HushApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsControllerProvider).value;
    final localeCode = settings?.localeCode;

    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: hushTheme(Brightness.light),
      darkTheme: hushTheme(Brightness.dark),
      themeMode: settings?.themeMode ?? ThemeMode.system,
      locale: localeCode == null ? null : Locale(localeCode),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: _Root(settings: settings),
    );
  }
}

class _Root extends StatelessWidget {
  const _Root({required this.settings});

  final AppSettings? settings;

  @override
  Widget build(BuildContext context) {
    final current = settings;
    if (current == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return current.hasSource
        ? const VoiceNotesScreen()
        : const OnboardingScreen();
  }
}
