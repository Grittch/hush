import 'package:flutter/material.dart';

/// Gli stessi toni dell'icona: neutri con dominante calda, niente nero puro
/// ne grigio freddo. Il contrasto di queste coppie e verificato dai test.
const _paper = Color(0xFFF2EDE4);
const _paperDeep = Color(0xFFE5DDCF);
const _inkSoft = Color(0xFF3A342D);
const _ink = Color(0xFF1F1B17);
const _inkMuted = Color(0xFF5A5148);
const _paperMuted = Color(0xFFB8AE9F);
const _inkRaised = Color(0xFF2A241E);
const _rule = Color(0xFFD6CCBC);

/// Un taupe caldo di mezzo: serve solo a far generare a Material dei ruoli
/// tonali coerenti, i colori che si vedono sono quelli sopra.
const _seedColor = Color(0xFF8A7B6A);

@immutable
class HushTokens extends ThemeExtension<HushTokens> {
  const HushTokens({
    required this.gapSmall,
    required this.gap,
    required this.gapLarge,
    required this.cardRadius,
    required this.controlSize,
    required this.buttonHeight,
    required this.iconSize,
    required this.illustrationSize,
    required this.sliderTrack,
  });

  final double gapSmall;
  final double gap;
  final double gapLarge;
  final double cardRadius;
  final double controlSize;
  final double buttonHeight;
  final double iconSize;
  final double illustrationSize;
  final double sliderTrack;

  static const _defaults = HushTokens(
    gapSmall: 8,
    gap: 16,
    gapLarge: 28,
    cardRadius: 22,
    controlSize: 56,
    buttonHeight: 52,
    iconSize: 28,
    illustrationSize: 56,
    sliderTrack: 4,
  );

  @override
  HushTokens copyWith({
    double? gapSmall,
    double? gap,
    double? gapLarge,
    double? cardRadius,
    double? controlSize,
    double? buttonHeight,
    double? iconSize,
    double? illustrationSize,
    double? sliderTrack,
  }) {
    return HushTokens(
      gapSmall: gapSmall ?? this.gapSmall,
      gap: gap ?? this.gap,
      gapLarge: gapLarge ?? this.gapLarge,
      cardRadius: cardRadius ?? this.cardRadius,
      controlSize: controlSize ?? this.controlSize,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      iconSize: iconSize ?? this.iconSize,
      illustrationSize: illustrationSize ?? this.illustrationSize,
      sliderTrack: sliderTrack ?? this.sliderTrack,
    );
  }

  @override
  HushTokens lerp(HushTokens? other, double t) {
    if (other == null) return this;
    return HushTokens(
      gapSmall: _lerp(gapSmall, other.gapSmall, t),
      gap: _lerp(gap, other.gap, t),
      gapLarge: _lerp(gapLarge, other.gapLarge, t),
      cardRadius: _lerp(cardRadius, other.cardRadius, t),
      controlSize: _lerp(controlSize, other.controlSize, t),
      buttonHeight: _lerp(buttonHeight, other.buttonHeight, t),
      iconSize: _lerp(iconSize, other.iconSize, t),
      illustrationSize: _lerp(illustrationSize, other.illustrationSize, t),
      sliderTrack: _lerp(sliderTrack, other.sliderTrack, t),
    );
  }

  static double _lerp(double a, double b, double t) => a + (b - a) * t;
}

extension HushTheme on ThemeData {
  HushTokens get tokens => extension<HushTokens>() ?? HushTokens._defaults;
}

ColorScheme _hushColorScheme(Brightness brightness) {
  final base = ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: brightness,
  );
  return switch (brightness) {
    Brightness.light => base.copyWith(
      primary: _inkSoft,
      onPrimary: _paper,
      primaryContainer: _paperDeep,
      onPrimaryContainer: _ink,
      surface: _paper,
      onSurface: _ink,
      surfaceContainerLowest: _paper,
      surfaceContainerLow: _paperDeep,
      surfaceContainer: _paperDeep,
      onSurfaceVariant: _inkMuted,
      outlineVariant: _rule,
    ),
    Brightness.dark => base.copyWith(
      primary: _paperDeep,
      onPrimary: _ink,
      primaryContainer: _inkSoft,
      onPrimaryContainer: _paper,
      surface: _ink,
      onSurface: _paper,
      surfaceContainerLowest: _ink,
      surfaceContainerLow: _inkRaised,
      surfaceContainer: _inkRaised,
      onSurfaceVariant: _paperMuted,
      outlineVariant: _inkSoft,
    ),
  };
}

ThemeData hushTheme(Brightness brightness) {
  final scheme = _hushColorScheme(brightness);
  const tokens = HushTokens._defaults;

  return ThemeData(
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    extensions: const [tokens],
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.cardRadius),
      ),
      margin: EdgeInsets.zero,
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.cardRadius),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: tokens.gap,
        vertical: tokens.gapSmall,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: Size.fromHeight(tokens.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.cardRadius),
        ),
      ),
    ),
    sliderTheme: SliderThemeData(trackHeight: tokens.sliderTrack),
  );
}
