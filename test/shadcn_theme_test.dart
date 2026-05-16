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
      expect(
        ShadcnStyles.values.map((tokens) => tokens.name),
        containsAll(ShadcnStyleName.values),
      );
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

    test('theme and style labels stay stable for app configuration UIs', () {
      expect(
        {for (final theme in ShadcnThemeName.values) theme: theme.label},
        {
          ShadcnThemeName.neutral: 'Neutral',
          ShadcnThemeName.stone: 'Stone',
          ShadcnThemeName.zinc: 'Zinc',
          ShadcnThemeName.mauve: 'Mauve',
          ShadcnThemeName.olive: 'Olive',
          ShadcnThemeName.mist: 'Mist',
          ShadcnThemeName.taupe: 'Taupe',
          ShadcnThemeName.amber: 'Amber',
          ShadcnThemeName.blue: 'Blue',
          ShadcnThemeName.cyan: 'Cyan',
          ShadcnThemeName.emerald: 'Emerald',
          ShadcnThemeName.fuchsia: 'Fuchsia',
          ShadcnThemeName.green: 'Green',
          ShadcnThemeName.indigo: 'Indigo',
          ShadcnThemeName.lime: 'Lime',
          ShadcnThemeName.orange: 'Orange',
          ShadcnThemeName.pink: 'Pink',
          ShadcnThemeName.purple: 'Purple',
          ShadcnThemeName.red: 'Red',
          ShadcnThemeName.rose: 'Rose',
          ShadcnThemeName.sky: 'Sky',
          ShadcnThemeName.teal: 'Teal',
          ShadcnThemeName.violet: 'Violet',
          ShadcnThemeName.yellow: 'Yellow',
        },
      );
      expect(
        {for (final style in ShadcnStyleName.values) style: style.label},
        {
          ShadcnStyleName.vega: 'Vega',
          ShadcnStyleName.nova: 'Nova',
          ShadcnStyleName.maia: 'Maia',
          ShadcnStyleName.lyra: 'Lyra',
          ShadcnStyleName.mira: 'Mira',
          ShadcnStyleName.luma: 'Luma',
          ShadcnStyleName.sera: 'Sera',
        },
      );
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
          for (final entry in map.entries) {
            expect(colors.tryGet(entry.key), entry.value);
            expect(colors.get(entry.key), entry.value);
          }
          expect(colors.tryGet('unknown'), isNull);
          expect(() => colors.get('unknown'), throwsArgumentError);
        }
      }
    });

    test(
      'theme source metadata and classifications stay internally consistent',
      () {
        expect(ShadcnThemes.sourceUrl, startsWith('https://github.com/'));
        expect(
          ShadcnThemes.baseColorThemes.intersection(ShadcnThemes.accentThemes),
          isEmpty,
        );
        expect({
          ...ShadcnThemes.baseColorThemes,
          ...ShadcnThemes.accentThemes,
        }, ShadcnThemeName.values.toSet());
        for (final theme in ShadcnThemes.baseColorThemes) {
          expect(theme.tokens.light.background, isA<Color>());
          expect(theme.isBaseColorTheme, isTrue);
        }
        for (final theme in ShadcnThemes.accentThemes) {
          expect(
            theme.tokens.light.background,
            ShadcnThemes.defaultBaseTheme.tokens.light.background,
          );
          expect(theme.isAccentTheme, isTrue);
        }
      },
    );

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
      expect(mira.buttonHeightFor(ShadcnControlSize.sm), 24);
      expect(mira.buttonHeightFor(ShadcnControlSize.md), 28);
      expect(maia.buttonHeightFor(ShadcnControlSize.md), 36);
      expect(maia.buttonHeightFor(ShadcnControlSize.lg), 40);
      expect(sera.inputHeightFor(ShadcnControlSize.xs), 36);
      expect(sera.inputHeightFor(ShadcnControlSize.md), 40);
      expect(sera.inputHeightFor(ShadcnControlSize.lg), 44);
      expect(mira.iconButtonSizeFor(ShadcnControlSize.sm), 24);
      expect(maia.iconButtonSizeFor(ShadcnControlSize.md), 36);
      expect(maia.iconButtonSizeFor(ShadcnControlSize.lg), 40);
      expect(mira.buttonPadding, const EdgeInsets.symmetric(horizontal: 8));
      expect(
        maia.inputPadding,
        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      );
      expect(sera.cardPaddingInsets, const EdgeInsets.all(24));
      expect(mira.cardPaddingSmInsets, const EdgeInsets.all(12));
      expect(sera.dialogPaddingInsets, const EdgeInsets.all(24));
      expect(
        maia.menuItemPadding,
        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      );
      expect(mira.copyWith(), mira);
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
      expect(
        mira.filledButtonTheme.style!.padding!.resolve({}),
        ShadcnStyleName.mira.tokens.buttonPadding,
      );
      expect(mira.inputDecorationTheme.constraints?.minHeight, 28);
      expect(
        mira.inputDecorationTheme.contentPadding,
        ShadcnStyleName.mira.tokens.inputPadding,
      );
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

    test('resolves control state colors from shadcn tokens', () {
      final data = ShadcnThemeData.light(
        theme: ShadcnThemeName.cyan,
        style: ShadcnStyleName.nova,
      );
      final extension = data.shadcnTheme;
      final colors = extension.colors;
      final style = extension.style;
      final buttonStyle = data.filledButtonTheme.style!;

      expect(
        buttonStyle.foregroundColor!.resolve({WidgetState.disabled}),
        colors.mutedForeground.withValues(alpha: 0.50),
      );
      expect(
        buttonStyle.backgroundColor!.resolve({WidgetState.disabled}),
        colors.muted.withValues(alpha: 0.50),
      );
      expect(
        buttonStyle.iconColor!.resolve({WidgetState.disabled}),
        colors.mutedForeground.withValues(alpha: 0.50),
      );
      expect(
        buttonStyle.overlayColor!.resolve({WidgetState.disabled}),
        Colors.transparent,
      );
      expect(
        buttonStyle.overlayColor!.resolve({WidgetState.pressed}),
        colors.accent.withValues(alpha: style.stateLayerOpacity + 0.06),
      );
      expect(
        buttonStyle.overlayColor!.resolve({WidgetState.focused}),
        colors.accent.withValues(alpha: style.stateLayerOpacity + 0.04),
      );
      expect(
        buttonStyle.overlayColor!.resolve({WidgetState.hovered}),
        colors.accent.withValues(alpha: style.stateLayerOpacity),
      );
      expect(buttonStyle.overlayColor!.resolve({}), isNull);

      expect(
        data.checkboxTheme.fillColor?.resolve({WidgetState.disabled}),
        colors.input.withValues(alpha: 0.50),
      );
      expect(
        data.checkboxTheme.fillColor?.resolve({WidgetState.selected}),
        colors.primary,
      );
      expect(data.checkboxTheme.fillColor?.resolve({}), Colors.transparent);
      expect(
        data.radioTheme.fillColor?.resolve({WidgetState.disabled}),
        colors.mutedForeground,
      );
      expect(
        data.radioTheme.fillColor?.resolve({WidgetState.selected}),
        colors.primary,
      );
      expect(data.radioTheme.fillColor?.resolve({}), colors.input);
      expect(
        data.switchTheme.thumbColor?.resolve({WidgetState.disabled}),
        colors.mutedForeground,
      );
      expect(data.switchTheme.thumbColor?.resolve({}), colors.background);
      expect(
        data.switchTheme.trackColor?.resolve({WidgetState.disabled}),
        colors.input.withValues(alpha: 0.50),
      );
      expect(
        data.switchTheme.trackColor?.resolve({WidgetState.selected}),
        colors.primary,
      );
      expect(data.switchTheme.trackColor?.resolve({}), colors.input);
      expect(
        data.switchTheme.overlayColor?.resolve({WidgetState.pressed}),
        colors.ring.withValues(alpha: style.stateLayerOpacity + 0.06),
      );
      expect(
        data.navigationBarTheme.labelTextStyle?.resolve({
          WidgetState.selected,
        })?.color,
        colors.foreground,
      );
      expect(
        data.navigationBarTheme.labelTextStyle?.resolve({})?.color,
        colors.mutedForeground,
      );
    });

    test('maps extended Material component themes from shadcn tokens', () {
      final data = ShadcnThemeData.dark(
        theme: ShadcnThemeName.violet,
        style: ShadcnStyleName.maia,
      );
      final extension = data.shadcnTheme;

      expect(data.textSelectionTheme.cursorColor, extension.colors.ring);
      expect(
        data.textSelectionTheme.selectionHandleColor,
        extension.colors.primary,
      );
      expect(
        data.dropdownMenuTheme.textStyle?.color,
        extension.colors.foreground,
      );
      expect(
        data.dropdownMenuTheme.textStyle?.fontSize,
        data.textTheme.bodyMedium?.fontSize,
      );
      expect(
        data.dropdownMenuTheme.inputDecorationTheme?.constraints?.minHeight,
        extension.style.inputHeight,
      );
      expect(
        data.dropdownMenuTheme.menuStyle?.backgroundColor?.resolve({}),
        extension.colors.popover,
      );
      expect(
        data.floatingActionButtonTheme.backgroundColor,
        extension.colors.primary,
      );
      expect(
        data.floatingActionButtonTheme.foregroundColor,
        extension.colors.primaryForeground,
      );
      expect(
        data.navigationBarTheme.backgroundColor,
        extension.colors.background,
      );
      expect(data.navigationBarTheme.indicatorColor, extension.colors.accent);
      expect(
        data.navigationBarTheme.iconTheme?.resolve({
          WidgetState.selected,
        })?.color,
        extension.colors.primary,
      );
      expect(
        data.navigationBarTheme.iconTheme?.resolve({})?.color,
        extension.colors.mutedForeground,
      );
      expect(data.snackBarTheme.behavior, SnackBarBehavior.floating);
      expect(data.snackBarTheme.closeIconColor, extension.colors.background);
      expect(
        data.snackBarTheme.contentTextStyle?.color,
        extension.colors.background,
      );
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
      expect(extension.brightness, Brightness.dark);
      expect(extension.fontFamily, isNull);
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

    testWidgets('BuildContext accessors expose the active extension', (
      tester,
    ) async {
      ShadcnThemeExtension? optional;
      ShadcnThemeExtension? required;

      await tester.pumpWidget(
        MaterialApp(
          key: const ValueKey('shadcn-app'),
          theme: ShadcnThemeData.light(
            theme: ShadcnThemeName.rose,
            style: ShadcnStyleName.luma,
          ),
          home: Builder(
            builder: (context) {
              optional = context.maybeShadcnTheme;
              required = context.shadcnTheme;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(optional, isNotNull);
      expect(required, same(optional));
      expect(required?.theme.name, ShadcnThemeName.rose);
      expect(required?.style.name, ShadcnStyleName.luma);

      optional = null;
      required = null;
      await tester.pumpWidget(
        MaterialApp(
          key: const ValueKey('plain-app'),
          home: Builder(
            builder: (context) {
              optional = context.maybeShadcnTheme;
              expect(() => context.shadcnTheme, throwsStateError);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(optional, isNull);
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

      final copied = light.copyWith(
        style: ShadcnStyleName.sera.tokens,
        brightness: Brightness.dark,
        fontFamily: 'Inter',
      );
      final cleared = copied.copyWith(fontFamily: null);
      final mixed = light.lerp(dark, 0.5);
      final unchanged = light.lerp(null, 0.5);
      final duplicate = light.copyWith();

      expect(copied.theme, light.theme);
      expect(copied.colors, light.colors);
      expect(copied.style.name, ShadcnStyleName.sera);
      expect(copied.brightness, Brightness.dark);
      expect(copied.fontFamily, 'Inter');
      expect(cleared.fontFamily, isNull);
      expect(mixed.theme.name, ShadcnThemeName.orange);
      expect(mixed.style.name, ShadcnStyleName.sera);
      expect(mixed.brightness, Brightness.dark);
      expect(
        mixed.colors.primary,
        Color.lerp(light.colors.primary, dark.colors.primary, 0.5),
      );
      expect(mixed.radius.base, 10);
      expect(unchanged, same(light));
      expect(duplicate, light);
      expect(duplicate.hashCode, light.hashCode);
      expect(duplicate.toString(), contains('ShadcnThemeExtension'));
    });
  });

  group('token value semantics', () {
    test('theme, color, and radius tokens compare by value', () {
      final neutral = ShadcnThemeName.neutral.tokens;
      final colors = neutral.light;
      final copiedTheme = ShadcnThemeTokens(
        name: neutral.name,
        title: neutral.title,
        radius: neutral.radius,
        light: neutral.light,
        dark: neutral.dark,
      );
      final copiedColors = _copyColors(colors);
      const radius = ShadcnRadiusScale(10);

      expect(copiedTheme, neutral);
      expect(copiedTheme.hashCode, neutral.hashCode);
      expect(copiedTheme.toString(), contains('Neutral'));
      expect(copiedColors, colors);
      expect(copiedColors.hashCode, colors.hashCode);
      expect(copiedColors.toString(), contains('primary'));
      expect(radius.none, 0);
      expect(radius.sm, 6);
      expect(radius.md, 8);
      expect(radius.lg, 10);
      expect(radius.xl, 14);
      expect(radius.x2l, 18);
      expect(radius.x3l, 22);
      expect(radius.x4l, 26);
      expect(radius.borderRadius(8), BorderRadius.circular(8));
      expect(radius, const ShadcnRadiusScale(10));
      expect(radius.hashCode, const ShadcnRadiusScale(10).hashCode);
      expect(radius.toString(), contains('10'));
    });

    test('text style tokens compare by value', () {
      final typography = ShadcnStyleName.nova.tokens.text;
      final copiedTypography = _copyTypography(typography);
      final body = ShadcnStyleName.nova.tokens.text.bodyMedium;
      final sameBody = ShadcnTextStyleToken(
        fontSize: body.fontSize,
        lineHeight: body.lineHeight,
        fontWeight: body.fontWeight,
        letterSpacing: body.letterSpacing,
      );
      final differentBody = ShadcnTextStyleToken(
        fontSize: body.fontSize + 1,
        lineHeight: body.lineHeight,
        fontWeight: body.fontWeight,
        letterSpacing: body.letterSpacing,
      );

      expect(copiedTypography, typography);
      expect(copiedTypography.hashCode, typography.hashCode);
      expect(copiedTypography.toString(), contains('ShadcnTypographyTokens'));
      expect(sameBody, body);
      expect(sameBody.hashCode, body.hashCode);
      expect(differentBody, isNot(body));
      expect(body.toString(), contains('fontSize'));
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

ShadcnColorTokens _copyColors(ShadcnColorTokens colors) {
  return ShadcnColorTokens(
    background: colors.background,
    foreground: colors.foreground,
    card: colors.card,
    cardForeground: colors.cardForeground,
    popover: colors.popover,
    popoverForeground: colors.popoverForeground,
    primary: colors.primary,
    primaryForeground: colors.primaryForeground,
    secondary: colors.secondary,
    secondaryForeground: colors.secondaryForeground,
    muted: colors.muted,
    mutedForeground: colors.mutedForeground,
    accent: colors.accent,
    accentForeground: colors.accentForeground,
    destructive: colors.destructive,
    border: colors.border,
    input: colors.input,
    ring: colors.ring,
    chart1: colors.chart1,
    chart2: colors.chart2,
    chart3: colors.chart3,
    chart4: colors.chart4,
    chart5: colors.chart5,
    sidebar: colors.sidebar,
    sidebarForeground: colors.sidebarForeground,
    sidebarPrimary: colors.sidebarPrimary,
    sidebarPrimaryForeground: colors.sidebarPrimaryForeground,
    sidebarAccent: colors.sidebarAccent,
    sidebarAccentForeground: colors.sidebarAccentForeground,
    sidebarBorder: colors.sidebarBorder,
    sidebarRing: colors.sidebarRing,
  );
}

ShadcnTypographyTokens _copyTypography(ShadcnTypographyTokens typography) {
  return ShadcnTypographyTokens(
    displayLarge: typography.displayLarge,
    displayMedium: typography.displayMedium,
    displaySmall: typography.displaySmall,
    headlineLarge: typography.headlineLarge,
    headlineMedium: typography.headlineMedium,
    headlineSmall: typography.headlineSmall,
    titleLarge: typography.titleLarge,
    titleMedium: typography.titleMedium,
    titleSmall: typography.titleSmall,
    bodyLarge: typography.bodyLarge,
    bodyMedium: typography.bodyMedium,
    bodySmall: typography.bodySmall,
    labelLarge: typography.labelLarge,
    labelMedium: typography.labelMedium,
    labelSmall: typography.labelSmall,
  );
}
