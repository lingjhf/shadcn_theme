import 'package:flutter/material.dart';

import 'shadcn_names.dart';
import 'shadcn_style_registry.dart';
import 'shadcn_style_tokens.dart';
import 'shadcn_theme_extension.dart';
import 'shadcn_theme_registry.dart';
import 'shadcn_theme_tokens.dart';

/// Factory for producing Flutter [ThemeData] from shadcn tokens.
abstract final class ShadcnThemeData {
  static ThemeData resolve({
    required Brightness brightness,
    ShadcnThemeName theme = ShadcnThemeName.neutral,
    ShadcnStyleName style = ShadcnStyleName.nova,
    double? radius,
    String? fontFamily,
  }) {
    return _build(
      brightness: brightness,
      theme: theme,
      style: style,
      radius: radius,
      fontFamily: fontFamily,
    );
  }

  static ThemeData light({
    ShadcnThemeName theme = ShadcnThemeName.neutral,
    ShadcnStyleName style = ShadcnStyleName.nova,
    double? radius,
    String? fontFamily,
  }) {
    return _build(
      brightness: Brightness.light,
      theme: theme,
      style: style,
      radius: radius,
      fontFamily: fontFamily,
    );
  }

  static ThemeData dark({
    ShadcnThemeName theme = ShadcnThemeName.neutral,
    ShadcnStyleName style = ShadcnStyleName.nova,
    double? radius,
    String? fontFamily,
  }) {
    return _build(
      brightness: Brightness.dark,
      theme: theme,
      style: style,
      radius: radius,
      fontFamily: fontFamily,
    );
  }

  static ThemeData _build({
    required Brightness brightness,
    required ShadcnThemeName theme,
    required ShadcnStyleName style,
    required double? radius,
    required String? fontFamily,
  }) {
    final themeTokens = ShadcnThemes.get(theme);
    final colors = themeTokens.colorsFor(brightness);
    final radiusScale = themeTokens.radiusScale(radius);
    final styleTokens = ShadcnStyles.get(
      style,
    ).withBaseRadius(radiusScale.base);
    final textTheme = styleTokens.text.toTextTheme(
      foreground: colors.foreground,
      mutedForeground: colors.mutedForeground,
      fontFamily: fontFamily,
    );
    final colorScheme = _colorScheme(brightness, colors);
    final extension = ShadcnThemeExtension(
      theme: themeTokens,
      colors: colors,
      style: styleTokens,
      radius: radiusScale,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.background,
      canvasColor: colors.background,
      cardColor: colors.card,
      dividerColor: colors.border,
      focusColor: _withAlpha(colors.ring, styleTokens.focusRingOpacity),
      hoverColor: _withAlpha(colors.accent, styleTokens.stateLayerOpacity),
      highlightColor: _withAlpha(colors.accent, 0.12),
      splashColor: _withAlpha(colors.accent, 0.12),
      disabledColor: _withAlpha(colors.mutedForeground, 0.50),
      visualDensity: styleTokens.visualDensity,
      fontFamily: fontFamily,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      iconTheme: IconThemeData(
        color: colors.foreground,
        size: styleTokens.iconSize,
      ),
      primaryIconTheme: IconThemeData(
        color: colors.primaryForeground,
        size: styleTokens.iconSize,
      ),
      appBarTheme: AppBarThemeData(
        backgroundColor: colors.background,
        foregroundColor: colors.foreground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
        iconTheme: IconThemeData(
          color: colors.foreground,
          size: styleTokens.iconSize,
        ),
      ),
      cardTheme: CardThemeData(
        color: colors.card,
        surfaceTintColor: Colors.transparent,
        shadowColor: _withAlpha(colors.foreground, 0.10),
        elevation: styleTokens.cardElevation,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(styleTokens.cardRadius),
          side: BorderSide(
            color: colors.border,
            width: styleTokens.borderWidth,
          ),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.popover,
        surfaceTintColor: Colors.transparent,
        elevation: styleTokens.dialogElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(styleTokens.dialogRadius),
          side: BorderSide(
            color: colors.border,
            width: styleTokens.borderWidth,
          ),
        ),
        titleTextStyle: textTheme.headlineSmall,
        contentTextStyle: textTheme.bodyMedium,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.popover,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(styleTokens.dialogRadius),
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colors.border,
        thickness: styleTokens.borderWidth,
        space: styleTokens.spacingUnit,
      ),
      inputDecorationTheme: _inputDecoration(colors, styleTokens),
      filledButtonTheme: FilledButtonThemeData(
        style: _buttonStyle(
          colors: colors,
          style: styleTokens,
          foreground: colors.primaryForeground,
          background: colors.primary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: _buttonStyle(
          colors: colors,
          style: styleTokens,
          foreground: colors.primaryForeground,
          background: colors.primary,
          elevation: styleTokens.cardElevation,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: _buttonStyle(
          colors: colors,
          style: styleTokens,
          foreground: colors.foreground,
          background: colors.background,
          side: BorderSide(
            color: colors.border,
            width: styleTokens.borderWidth,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: _buttonStyle(
          colors: colors,
          style: styleTokens,
          foreground: colors.primary,
          background: Colors.transparent,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll(
            Size.square(styleTokens.iconButtonSize),
          ),
          fixedSize: WidgetStatePropertyAll(
            Size.square(styleTokens.iconButtonSize),
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          iconSize: WidgetStatePropertyAll(styleTokens.iconSize),
          foregroundColor: _stateColor(
            colors.foreground,
            colors.mutedForeground,
          ),
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          overlayColor: _overlayColor(
            colors.accent,
            styleTokens.stateLayerOpacity,
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(styleTokens.buttonRadius),
            ),
          ),
        ),
      ),
      checkboxTheme: _checkboxTheme(colors, styleTokens),
      radioTheme: _radioTheme(colors, styleTokens),
      switchTheme: _switchTheme(colors, styleTokens),
      sliderTheme: _sliderTheme(colors, styleTokens),
      tabBarTheme: TabBarThemeData(
        labelColor: colors.foreground,
        unselectedLabelColor: colors.mutedForeground,
        indicatorColor: colors.primary,
        dividerColor: colors.border,
        labelStyle: textTheme.labelLarge,
        unselectedLabelStyle: textTheme.labelLarge,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colors.popover,
          border: Border.all(
            color: colors.border,
            width: styleTokens.borderWidth,
          ),
          borderRadius: BorderRadius.circular(styleTokens.menuItemRadius),
          boxShadow: _shadows(colors, styleTokens.dialogElevation),
        ),
        textStyle: textTheme.bodySmall?.copyWith(
          color: colors.popoverForeground,
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: colors.popover,
        surfaceTintColor: Colors.transparent,
        elevation: styleTokens.dialogElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(styleTokens.dialogRadius),
          side: BorderSide(
            color: colors.border,
            width: styleTokens.borderWidth,
          ),
        ),
        textStyle: textTheme.bodyMedium,
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(colors.popover),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          elevation: WidgetStatePropertyAll(styleTokens.dialogElevation),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(styleTokens.dialogRadius),
              side: BorderSide(
                color: colors.border,
                width: styleTokens.borderWidth,
              ),
            ),
          ),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: styleTokens.menuItemPaddingX / 2,
              vertical: styleTokens.menuItemPaddingY / 2,
            ),
          ),
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: colors.mutedForeground,
        textColor: colors.foreground,
        selectedColor: colors.accentForeground,
        selectedTileColor: colors.accent,
        dense: styleTokens.visualDensity.vertical < 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(styleTokens.menuItemRadius),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colors.secondary,
        selectedColor: colors.primary,
        disabledColor: _withAlpha(colors.muted, 0.60),
        labelStyle: textTheme.labelMedium?.copyWith(
          color: colors.secondaryForeground,
        ),
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: colors.primaryForeground,
        ),
        side: BorderSide(color: colors.border, width: styleTokens.borderWidth),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(styleTokens.buttonRadius),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colors.primary,
        linearTrackColor: colors.muted,
        circularTrackColor: colors.muted,
      ),
      extensions: [extension],
    );
  }

  static ColorScheme _colorScheme(
    Brightness brightness,
    ShadcnColorTokens colors,
  ) {
    final base = ColorScheme.fromSeed(
      seedColor: colors.primary,
      brightness: brightness,
    );
    return base.copyWith(
      brightness: brightness,
      primary: colors.primary,
      onPrimary: colors.primaryForeground,
      primaryContainer: colors.primary,
      onPrimaryContainer: colors.primaryForeground,
      secondary: colors.secondary,
      onSecondary: colors.secondaryForeground,
      secondaryContainer: colors.secondary,
      onSecondaryContainer: colors.secondaryForeground,
      tertiary: colors.accent,
      onTertiary: colors.accentForeground,
      tertiaryContainer: colors.accent,
      onTertiaryContainer: colors.accentForeground,
      error: colors.destructive,
      onError: _readableOnColor(colors.destructive),
      surface: colors.background,
      onSurface: colors.foreground,
      surfaceContainerLowest: colors.background,
      surfaceContainerLow: colors.card,
      surfaceContainer: colors.card,
      surfaceContainerHigh: colors.popover,
      surfaceContainerHighest: colors.muted,
      onSurfaceVariant: colors.mutedForeground,
      outline: colors.border,
      outlineVariant: colors.input,
      shadow: _withAlpha(colors.foreground, 0.20),
      scrim: _withAlpha(Colors.black, 0.50),
      inverseSurface: colors.foreground,
      onInverseSurface: colors.background,
      inversePrimary: colors.primaryForeground,
      surfaceTint: Colors.transparent,
    );
  }

  static InputDecorationThemeData _inputDecoration(
    ShadcnColorTokens colors,
    ShadcnStyleTokens style,
  ) {
    final radius = BorderRadius.circular(style.inputRadius);
    final baseBorder = OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: colors.input, width: style.borderWidth),
    );
    final focusedBorder = OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: colors.ring, width: style.focusRingWidth),
    );
    final errorBorder = OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(
        color: colors.destructive,
        width: style.borderWidth,
      ),
    );
    return InputDecorationThemeData(
      isDense: true,
      filled: true,
      fillColor: _withAlpha(colors.input, 0.30),
      hoverColor: _withAlpha(colors.input, 0.50),
      iconColor: colors.mutedForeground,
      prefixIconColor: colors.mutedForeground,
      suffixIconColor: colors.mutedForeground,
      hintStyle: TextStyle(color: colors.mutedForeground),
      labelStyle: TextStyle(color: colors.mutedForeground),
      floatingLabelStyle: TextStyle(color: colors.ring),
      errorStyle: TextStyle(color: colors.destructive),
      contentPadding: EdgeInsets.symmetric(
        horizontal: style.inputPaddingX,
        vertical: style.inputPaddingY,
      ),
      constraints: BoxConstraints(minHeight: style.inputHeight),
      border: baseBorder,
      enabledBorder: baseBorder,
      disabledBorder: baseBorder.copyWith(
        borderSide: BorderSide(color: _withAlpha(colors.input, 0.50)),
      ),
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: errorBorder.copyWith(
        borderSide: BorderSide(
          color: colors.destructive,
          width: style.focusRingWidth,
        ),
      ),
    );
  }

  static ButtonStyle _buttonStyle({
    required ShadcnColorTokens colors,
    required ShadcnStyleTokens style,
    required Color foreground,
    required Color background,
    BorderSide? side,
    double elevation = 0,
  }) {
    final text = TextStyle(
      fontSize: style.buttonFontSize,
      fontWeight: style.buttonFontWeight,
      letterSpacing: style.buttonLetterSpacing,
    );
    return ButtonStyle(
      textStyle: WidgetStatePropertyAll(text),
      foregroundColor: _stateColor(foreground, colors.mutedForeground),
      backgroundColor: _stateBackground(background, colors.muted),
      overlayColor: _overlayColor(colors.accent, style.stateLayerOpacity),
      elevation: WidgetStatePropertyAll(elevation),
      shadowColor: WidgetStatePropertyAll(_withAlpha(colors.foreground, 0.10)),
      surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
      minimumSize: WidgetStatePropertyAll(Size(0, style.buttonHeight)),
      fixedSize: WidgetStatePropertyAll(Size.fromHeight(style.buttonHeight)),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: style.buttonPaddingX),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(style.buttonRadius),
        ),
      ),
      side: side == null ? null : WidgetStatePropertyAll(side),
      iconSize: WidgetStatePropertyAll(style.iconSize),
      iconColor: _stateColor(foreground, colors.mutedForeground),
    );
  }

  static CheckboxThemeData _checkboxTheme(
    ShadcnColorTokens colors,
    ShadcnStyleTokens style,
  ) {
    return CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: style.visualDensity,
      checkColor: WidgetStatePropertyAll(colors.primaryForeground),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return _withAlpha(colors.input, 0.50);
        }
        if (states.contains(WidgetState.selected)) {
          return colors.primary;
        }
        return Colors.transparent;
      }),
      side: BorderSide(color: colors.input, width: style.borderWidth),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(style.inputRadius / 2),
      ),
    );
  }

  static RadioThemeData _radioTheme(
    ShadcnColorTokens colors,
    ShadcnStyleTokens style,
  ) {
    return RadioThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: style.visualDensity,
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.mutedForeground;
        }
        if (states.contains(WidgetState.selected)) {
          return colors.primary;
        }
        return colors.input;
      }),
    );
  }

  static SwitchThemeData _switchTheme(
    ShadcnColorTokens colors,
    ShadcnStyleTokens style,
  ) {
    return SwitchThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.mutedForeground;
        }
        return colors.background;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return _withAlpha(colors.input, 0.50);
        }
        if (states.contains(WidgetState.selected)) {
          return colors.primary;
        }
        return colors.input;
      }),
      trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
      overlayColor: _overlayColor(colors.ring, style.stateLayerOpacity),
    );
  }

  static SliderThemeData _sliderTheme(
    ShadcnColorTokens colors,
    ShadcnStyleTokens style,
  ) {
    return SliderThemeData(
      activeTrackColor: colors.primary,
      inactiveTrackColor: colors.muted,
      thumbColor: colors.primary,
      overlayColor: _withAlpha(colors.ring, style.stateLayerOpacity),
      valueIndicatorColor: colors.popover,
      valueIndicatorTextStyle: style.text.labelSmall.toTextStyle(
        colors.popoverForeground,
        null,
      ),
      thumbShape: RoundSliderThumbShape(
        enabledThumbRadius: style.sliderThumbSize / 2,
      ),
    );
  }

  static WidgetStateProperty<Color?> _stateColor(
    Color enabled,
    Color disabled,
  ) {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return _withAlpha(disabled, 0.50);
      }
      return enabled;
    });
  }

  static WidgetStateProperty<Color?> _stateBackground(
    Color enabled,
    Color disabled,
  ) {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return _withAlpha(disabled, 0.50);
      }
      return enabled;
    });
  }

  static WidgetStateProperty<Color?> _overlayColor(
    Color color,
    double opacity,
  ) {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.transparent;
      }
      if (states.contains(WidgetState.pressed)) {
        return _withAlpha(color, opacity + 0.06);
      }
      if (states.contains(WidgetState.focused)) {
        return _withAlpha(color, opacity + 0.04);
      }
      if (states.contains(WidgetState.hovered)) {
        return _withAlpha(color, opacity);
      }
      return null;
    });
  }

  static List<BoxShadow> _shadows(ShadcnColorTokens colors, double elevation) {
    if (elevation <= 0) {
      return const [];
    }
    return [
      BoxShadow(
        color: _withAlpha(colors.foreground, elevation >= 2 ? 0.12 : 0.08),
        blurRadius: elevation >= 2 ? 18 : 8,
        offset: Offset(0, elevation >= 2 ? 8 : 2),
      ),
    ];
  }

  static Color _readableOnColor(Color color) {
    return color.computeLuminance() > 0.45 ? Colors.black : Colors.white;
  }

  static Color _withAlpha(Color color, double alpha) {
    return color.withValues(alpha: alpha.clamp(0, 1));
  }
}
