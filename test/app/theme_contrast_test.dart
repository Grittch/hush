import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hush/app/theme.dart';

/// Rapporto di contrasto WCAG 2.1 fra due colori opachi.
double contrastRatio(Color foreground, Color background) {
  final first = foreground.computeLuminance();
  final second = background.computeLuminance();
  final lighter = max(first, second);
  final darker = min(first, second);
  return (lighter + 0.05) / (darker + 0.05);
}

void main() {
  for (final brightness in Brightness.values) {
    group('palette ${brightness.name}', () {
      final scheme = hushTheme(brightness).colorScheme;

      test('il testo normale sulle superfici raggiunge 4.5:1', () {
        // Le card usano `surfaceContainerLow` e il testo secondario
        // `onSurfaceVariant`: e la coppia piu a rischio della palette, ed e
        // proprio quella della durata sotto ogni vocale.
        for (final background in [
          scheme.surface,
          scheme.surfaceContainerLow,
          scheme.surfaceContainer,
        ]) {
          expect(
            contrastRatio(scheme.onSurface, background),
            greaterThanOrEqualTo(4.5),
          );
          expect(
            contrastRatio(scheme.onSurfaceVariant, background),
            greaterThanOrEqualTo(4.5),
          );
        }
      });

      test('il testo sui colori di accento raggiunge 4.5:1', () {
        expect(
          contrastRatio(scheme.onPrimary, scheme.primary),
          greaterThanOrEqualTo(4.5),
        );
        expect(
          contrastRatio(scheme.onError, scheme.error),
          greaterThanOrEqualTo(4.5),
        );
      });

      test('le icone di accento raggiungono 3:1 sulle superfici', () {
        expect(
          contrastRatio(scheme.primary, scheme.surface),
          greaterThanOrEqualTo(3),
        );
      });
    });
  }

  test('i token del tema sono disponibili in entrambe le luminosita', () {
    for (final brightness in Brightness.values) {
      final tokens = hushTheme(brightness).tokens;
      expect(tokens.controlSize, greaterThanOrEqualTo(48));
      expect(tokens.buttonHeight, greaterThanOrEqualTo(48));
    }
  });
}
