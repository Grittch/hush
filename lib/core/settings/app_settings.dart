import 'package:flutter/material.dart' show ThemeMode;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    String? sourceFolderUri,
    @Default(ThemeMode.system) ThemeMode themeMode,
    String? localeCode,
  }) = _AppSettings;

  const AppSettings._();

  bool get hasSource => sourceFolderUri != null;
}
