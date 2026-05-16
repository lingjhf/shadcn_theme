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

    test('classifies base and accent color themes', () {
      expect(ShadcnThemes.defaultBaseTheme, ShadcnThemeName.neutral);
      expect(ShadcnThemes.baseColorThemes, hasLength(7));
      expect(ShadcnThemes.accentThemes, hasLength(17));
      expect(ShadcnThemes.sourceUrl, contains('registry/themes.ts'));
      expect(ShadcnThemeName.stone.isBaseColorTheme, isTrue);
      expect(ShadcnThemeName.taupe.isBaseColorTheme, isTrue);
      expect(ShadcnThemeName.blue.isAccentTheme, isTrue);
      expect(ShadcnThemeName.amber.isAccentTheme, isTrue);
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

    test('all color token maps expose the complete semantic contract', () {
      expect(
        ShadcnColorTokens.semanticTokenNames,
        hasLength(ShadcnColorTokens.semanticTokenCount),
      );
      for (final theme in ShadcnThemes.values) {
        for (final colors in [theme.light, theme.dark]) {
          final map = colors.toMap();

          expect(map, hasLength(ShadcnColorTokens.semanticTokenCount));
          expect(map.keys.toSet(), ShadcnColorTokens.semanticTokenNames);
          expect(map.values, everyElement(isA<Color>()));
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
      expect(
        ShadcnThemeName.stone.tokens.light.foreground,
        const Color(0xFF0C0A09),
      );
      expect(ShadcnThemeName.zinc.tokens.dark.input, const Color(0x26FFFFFF));
      expect(
        ShadcnThemeName.amber.tokens.light.chart2,
        const Color(0xFFFE9A00),
      );
      expect(
        ShadcnThemeName.blue.tokens.light.background,
        ShadcnThemeName.neutral.tokens.light.background,
      );
      expect(
        ShadcnThemeName.blue.tokens.dark.card,
        ShadcnThemeName.neutral.tokens.dark.card,
      );
    });

    test('token classes have stable value semantics', () {
      final neutralA = ShadcnThemeName.neutral.tokens;
      final neutralB = ShadcnThemes.get(ShadcnThemeName.neutral);
      final novaA = ShadcnStyleName.nova.tokens;
      final novaB = ShadcnStyles.get(ShadcnStyleName.nova);

      expect(neutralA, neutralB);
      expect(neutralA.hashCode, neutralB.hashCode);
      expect(neutralA.light, neutralB.light);
      expect(neutralA.light.hashCode, neutralB.light.hashCode);
      expect(neutralA.radiusScale(), const ShadcnRadiusScale(10));
      expect(novaA, novaB);
      expect(novaA.hashCode, novaB.hashCode);
      expect(novaA.text.bodyMedium, novaB.text.bodyMedium);
      expect(neutralA.toString(), contains('neutral'));
      expect(novaA.toString(), contains('nova'));
    });

    test('style size helpers expose preset-specific control dimensions', () {
      final mira = ShadcnStyleName.mira.tokens;
      final maia = ShadcnStyleName.maia.tokens;
      final sera = ShadcnStyleName.sera.tokens;

      expect(mira.buttonHeightFor(ShadcnControlSize.xs), 20);
      expect(mira.buttonHeightFor(ShadcnControlSize.md), 28);
      expect(maia.buttonHeightFor(ShadcnControlSize.md), 36);
      expect(maia.buttonHeightFor(ShadcnControlSize.lg), 40);
      expect(sera.inputHeightFor(ShadcnControlSize.md), 40);
      expect(sera.inputHeightFor(ShadcnControlSize.lg), 44);
      expect(mira.iconButtonSizeFor(ShadcnControlSize.sm), 24);
      expect(maia.iconButtonSizeFor(ShadcnControlSize.md), 36);
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
      expect(_buttonFixedHeight(nova), 32);
      expect(_buttonHeight(vega), 36);
      expect(_buttonFixedHeight(vega), 36);
      expect(_buttonText(sera).fontWeight, FontWeight.w600);
      expect(_buttonText(sera).letterSpacing, 1.6);
      expect(sera.textTheme.bodyMedium?.height, closeTo(24 / 14, 0.001));
    });

    test('maps component size tokens into Material component themes', () {
      final mira = ShadcnThemeData.light(style: ShadcnStyleName.mira);
      final maia = ShadcnThemeData.light(style: ShadcnStyleName.maia);
      final sera = ShadcnThemeData.light(style: ShadcnStyleName.sera);

      expect(_buttonHeight(mira), 28);
      expect(_buttonFixedHeight(mira), 28);
      expect(mira.inputDecorationTheme.constraints?.minHeight, 28);
      expect(maia.inputDecorationTheme.constraints?.minHeight, 36);
      expect(sera.inputDecorationTheme.constraints?.minHeight, 40);
    });

    test('maps component color and shape tokens into Material themes', () {
      final data = ShadcnThemeData.dark(
        theme: ShadcnThemeName.red,
        style: ShadcnStyleName.luma,
      );
      final extension = data.extension<ShadcnThemeExtension>()!;
      final cardShape = data.cardTheme.shape! as RoundedRectangleBorder;
      final dialogShape = data.dialogTheme.shape! as RoundedRectangleBorder;

      expect(cardShape.side.color, extension.colors.border);
      expect(cardShape.side.width, extension.style.borderWidth);
      expect(
        cardShape.borderRadius,
        BorderRadius.circular(extension.style.cardRadius),
      );
      expect(dialogShape.side.color, extension.colors.border);
      expect(
        dialogShape.borderRadius,
        BorderRadius.circular(extension.style.dialogRadius),
      );
      expect(data.sliderTheme.activeTrackColor, extension.colors.primary);
      expect(
        data.switchTheme.trackColor?.resolve({WidgetState.selected}),
        extension.colors.primary,
      );
      expect(data.progressIndicatorTheme.color, extension.colors.primary);
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
      final theme = ShadcnThemeData.resolve(
        brightness: Brightness.dark,
        theme: ShadcnThemeName.emerald,
        style: ShadcnStyleName.mira,
      );
      final extension = theme.shadcnTheme;

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

    test('ThemeData accessors expose optional and required extensions', () {
      final data = ShadcnThemeData.light(
        theme: ShadcnThemeName.violet,
        style: ShadcnStyleName.maia,
      );

      expect(data.maybeShadcnTheme, isNotNull);
      expect(data.shadcnTheme, same(data.maybeShadcnTheme));
      expect(data.shadcnTheme.theme.name, ShadcnThemeName.violet);
      expect(data.shadcnTheme.style.name, ShadcnStyleName.maia);
      expect(ThemeData.light().maybeShadcnTheme, isNull);
      expect(() => ThemeData.light().shadcnTheme, throwsStateError);
    });

    test('theme extension copyWith and lerp keep token semantics', () {
      final light = ShadcnThemeData.light(
        theme: ShadcnThemeName.neutral,
        style: ShadcnStyleName.nova,
      ).shadcnTheme;
      final dark = ShadcnThemeData.dark(
        theme: ShadcnThemeName.orange,
        style: ShadcnStyleName.sera,
      ).shadcnTheme;

      final copied = light.copyWith(style: ShadcnStyleName.sera.tokens);
      final mixed = light.lerp(dark, 0.5);

      expect(copied.theme, light.theme);
      expect(copied.colors, light.colors);
      expect(copied.style.name, ShadcnStyleName.sera);
      expect(mixed.theme.name, ShadcnThemeName.orange);
      expect(mixed.style.name, ShadcnStyleName.sera);
      expect(
        mixed.colors.primary,
        Color.lerp(light.colors.primary, dark.colors.primary, 0.5),
      );
      expect(mixed.radius.base, 10);
    });
  });
}

double _buttonHeight(ThemeData data) {
  return data.filledButtonTheme.style!.minimumSize!.resolve({})!.height;
}

double _buttonFixedHeight(ThemeData data) {
  return data.filledButtonTheme.style!.fixedSize!.resolve({})!.height;
}

TextStyle _buttonText(ThemeData data) {
  return data.filledButtonTheme.style!.textStyle!.resolve({})!;
}
