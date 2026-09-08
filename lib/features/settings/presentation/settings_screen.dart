import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/errors/hush_exception.dart';
import '../../../core/errors/hush_exception_message.dart';
import '../../../core/saf/saf_providers.dart';
import '../../../core/settings/app_settings.dart';
import '../../../core/settings/app_settings_controller.dart';
import '../../../l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(appSettingsControllerProvider).value;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: settings == null
          ? const Center(child: CircularProgressIndicator())
          : _SettingsList(settings: settings),
    );
  }
}

class _SettingsList extends ConsumerWidget {
  const _SettingsList({required this.settings});

  final AppSettings settings;

  Future<void> _changeFolder(BuildContext context, WidgetRef ref) async {
    try {
      final uri = await ref.read(sourceFolderPickerProvider).pick();
      if (uri == null) return;
      await ref
          .read(appSettingsControllerProvider.notifier)
          .setSourceFolderUri(uri);
    } on HushException catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.localized(AppLocalizations.of(context)))),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final tokens = theme.tokens;
    final controller = ref.read(appSettingsControllerProvider.notifier);

    return ListView(
      padding: EdgeInsets.all(tokens.gap),
      children: [
        _SectionTitle(l10n.settingsSourceFolder),
        ListTile(
          leading: const Icon(Icons.folder_outlined),
          title: Text(l10n.settingsChangeFolder),
          onTap: () => unawaited(_changeFolder(context, ref)),
        ),
        SizedBox(height: tokens.gapLarge),
        _SectionTitle(l10n.settingsAppearance),
        RadioGroup<ThemeMode>(
          groupValue: settings.themeMode,
          onChanged: (mode) {
            if (mode != null) unawaited(controller.setThemeMode(mode));
          },
          child: Column(
            children: [
              RadioListTile<ThemeMode>(
                value: ThemeMode.system,
                title: Text(l10n.settingsThemeSystem),
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.light,
                title: Text(l10n.settingsThemeLight),
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.dark,
                title: Text(l10n.settingsThemeDark),
              ),
            ],
          ),
        ),
        SizedBox(height: tokens.gapLarge),
        _SectionTitle(l10n.settingsLanguage),
        RadioGroup<String?>(
          groupValue: settings.localeCode,
          onChanged: (code) => unawaited(controller.setLocaleCode(code)),
          child: Column(
            children: [
              RadioListTile<String?>(
                value: null,
                title: Text(l10n.settingsLanguageSystem),
              ),
              RadioListTile<String?>(
                value: 'it',
                title: Text(l10n.settingsLanguageItalian),
              ),
              RadioListTile<String?>(
                value: 'en',
                title: Text(l10n.settingsLanguageEnglish),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: theme.tokens.gapSmall),
      child: Text(
        label,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
