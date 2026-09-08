import 'package:flutter/material.dart' show ThemeMode;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_settings.dart';

part 'app_settings_controller.g.dart';

const _sourceFolderKey = 'source_folder_uri';
const _themeModeKey = 'theme_mode';
const _localeKey = 'locale_code';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) =>
    SharedPreferences.getInstance();

@Riverpod(keepAlive: true)
class AppSettingsController extends _$AppSettingsController {
  @override
  Future<AppSettings> build() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    return AppSettings(
      sourceFolderUri: prefs.getString(_sourceFolderKey),
      themeMode: _readThemeMode(prefs),
      localeCode: prefs.getString(_localeKey),
    );
  }

  Future<void> setSourceFolderUri(String uri) async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setString(_sourceFolderKey, uri);
    _update((current) => current.copyWith(sourceFolderUri: uri));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setString(_themeModeKey, mode.name);
    _update((current) => current.copyWith(themeMode: mode));
  }

  Future<void> setLocaleCode(String? code) async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    if (code == null) {
      await prefs.remove(_localeKey);
    } else {
      await prefs.setString(_localeKey, code);
    }
    _update((current) => current.copyWith(localeCode: code));
  }

  void _update(AppSettings Function(AppSettings current) change) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(change(current));
  }

  ThemeMode _readThemeMode(SharedPreferences prefs) {
    final stored = prefs.getString(_themeModeKey);
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == stored,
      orElse: () => ThemeMode.system,
    );
  }
}
