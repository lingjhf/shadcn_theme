import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_theme/shadcn_theme.dart';

void main() {
  group('registries', () {
    test('include every public theme and style enum value', () {
      expect(ShadcnThemes.all.keys, containsAll(ShadcnThemeName.values));
      expect(ShadcnThemes.all.length, ShadcnThemeName.values.length);
      expect(ShadcnThemes.all.length, 24);

      expect(ShadcnStyles.all.keys, containsAll(ShadcnStyleName.values));
      expect(ShadcnStyles.all.length, ShadcnStyleName.values.length);
      expect(ShadcnStyles.all.length, 7);
    });

    test('all themes include chart and sidebar tokens', () {
      for (final tokens in ShadcnThemes.values) {
        for (final colors in [tokens.light, tokens.dark]) {
          expect(colors.charts, hasLength(5));
          expect(colors.sidebar, isA<Color>());
          expect(colors.sidebarForeground, isA<Color>());
          expect(colors.sidebarPrimary, isA<Color>());
          expect(colors.sidebarPrimaryForeground, isA<Color>());
          expect(colors.sidebarAccent, isA<Color>());
          expect(colors.sidebarAccentForeground, isA<Color>());
          expect(colors.sidebarBorder, isA<Color>());
          expect(colors.sidebarRing, isA<Color>());
        }
      }
    });

    test('representative official token values are stable', () {
      expect(
        ShadcnThemeName.neutral.tokens.light.primary,
        const Color(0xFF171717),
      );
      expect(
        ShadcnThemeName.neutral.tokens.dark.border,
        const Color(0x1AFFFFFF),
      );
      expect(
        ShadcnThemeName.blue.tokens.light.primary,
        const Color(0xFF1447E6),
      );
      expect(
        ShadcnThemeName.yellow.tokens.dark.primary,
        const Color(0xFFF0B100),
      );
    });
  });

  group('ThemeData generation', () {
    test('all theme/style/brightness combinations build', () {
      for (final theme in ShadcnThemeName.values) {
        for (final style in ShadcnStyleName.values) {
          final light = ShadcnThemeData.light(theme: theme, style: style);
          final dark = ShadcnThemeData.dark(theme: theme, style: style);

          expect(light.brightness, Brightness.light);
          expect(dark.brightness, Brightness.dark);
          expect(light.extension<ShadcnThemeExtension>(), isNotNull);
          expect(dark.extension<ShadcnThemeExtension>(), isNotNull);
          expect(light.colorScheme.primary, theme.tokens.light.primary);
          expect(dark.colorScheme.primary, theme.tokens.dark.primary);
        }
      }
    });

    test('maps color tokens into Material theme surfaces', () {
      final data = ShadcnThemeData.light(
        theme: ShadcnThemeName.zinc,
        style: ShadcnStyleName.nova,
      );
      final tokens = ShadcnThemeName.zinc.tokens.light;

      expect(data.scaffoldBackgroundColor, tokens.background);
      expect(data.colorScheme.surface, tokens.background);
      expect(data.colorScheme.onSurface, tokens.foreground);
      expect(data.colorScheme.primary, tokens.primary);
      expect(data.colorScheme.onPrimary, tokens.primaryForeground);
      expect(data.dividerTheme.color, tokens.border);
    });

    test('style presets change control density and typography', () {
      final nova = ShadcnThemeData.light(style: ShadcnStyleName.nova);
      final vega = ShadcnThemeData.light(style: ShadcnStyleName.vega);
      final sera = ShadcnThemeData.light(style: ShadcnStyleName.sera);

      expect(_buttonHeight(nova), 32);
      expect(_buttonHeight(vega), 36);
      expect(_buttonText(sera).fontWeight, FontWeight.w600);
      expect(_buttonText(sera).letterSpacing, 1.6);
      expect(sera.textTheme.bodyMedium?.height, closeTo(24 / 14, 0.001));
    });

    test(
      'radius override scales rounded styles and keeps sharp styles sharp',
      () {
        final luma = ShadcnThemeData.light(
          style: ShadcnStyleName.luma,
          radius: 20,
        ).extension<ShadcnThemeExtension>()!;
        final lyra = ShadcnThemeData.light(
          style: ShadcnStyleName.lyra,
          radius: 20,
        ).extension<ShadcnThemeExtension>()!;

        expect(luma.radius.base, 20);
        expect(luma.style.cardRadius, 52);
        expect(luma.style.inputRadius, 44);
        expect(lyra.style.cardRadius, 0);
        expect(lyra.style.inputRadius, 0);
      },
    );

    test('extension exposes active tokens', () {
      final theme = ShadcnThemeData.dark(
        theme: ShadcnThemeName.emerald,
        style: ShadcnStyleName.mira,
      );
      final extension = theme.extension<ShadcnThemeExtension>()!;

      expect(extension.theme.name, ShadcnThemeName.emerald);
      expect(extension.style.name, ShadcnStyleName.mira);
      expect(
        extension.colors.primary,
        ShadcnThemeName.emerald.tokens.dark.primary,
      );
      expect(
        extension.colors.charts.first,
        ShadcnThemeName.emerald.tokens.dark.chart1,
      );
    });
  });
}

double _buttonHeight(ThemeData data) {
  return data.filledButtonTheme.style!.minimumSize!.resolve({})!.height;
}

TextStyle _buttonText(ThemeData data) {
  return data.filledButtonTheme.style!.textStyle!.resolve({})!;
}
