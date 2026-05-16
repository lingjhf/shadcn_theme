import 'package:flutter/material.dart';

import 'shadcn_names.dart';

/// Standard control sizes used by shadcn style presets.
enum ShadcnControlSize { xs, sm, md, lg }

/// Non-color design tokens extracted from the official shadcn style presets.
class ShadcnStyleTokens {
  const ShadcnStyleTokens({
    required this.name,
    required this.title,
    required this.description,
    required this.spacingUnit,
    required this.visualDensity,
    required this.borderWidth,
    required this.focusRingWidth,
    required this.focusRingOpacity,
    required this.stateLayerOpacity,
    required this.buttonHeightXs,
    required this.buttonHeightSm,
    required this.buttonHeight,
    required this.buttonHeightLg,
    required this.buttonPaddingX,
    required this.buttonGap,
    required this.buttonRadius,
    required this.buttonFontSize,
    required this.buttonFontWeight,
    required this.buttonLetterSpacing,
    required this.uppercaseButtons,
    required this.iconSize,
    required this.iconButtonSize,
    required this.inputHeight,
    required this.inputHeightSm,
    required this.inputPaddingX,
    required this.inputPaddingY,
    required this.inputRadius,
    required this.inputFontSize,
    required this.checkboxSize,
    required this.switchWidth,
    required this.switchHeight,
    required this.sliderThumbSize,
    required this.cardPadding,
    required this.cardPaddingSm,
    required this.cardGap,
    required this.cardRadius,
    required this.cardElevation,
    required this.dialogPadding,
    required this.dialogGap,
    required this.dialogRadius,
    required this.dialogElevation,
    required this.menuItemPaddingX,
    required this.menuItemPaddingY,
    required this.menuItemRadius,
    required this.text,
  });

  final ShadcnStyleName name;
  final String title;
  final String description;
  final double spacingUnit;
  final VisualDensity visualDensity;
  final double borderWidth;
  final double focusRingWidth;
  final double focusRingOpacity;
  final double stateLayerOpacity;
  final double buttonHeightXs;
  final double buttonHeightSm;
  final double buttonHeight;
  final double buttonHeightLg;
  final double buttonPaddingX;
  final double buttonGap;
  final double buttonRadius;
  final double buttonFontSize;
  final FontWeight buttonFontWeight;
  final double buttonLetterSpacing;
  final bool uppercaseButtons;
  final double iconSize;
  final double iconButtonSize;
  final double inputHeight;
  final double inputHeightSm;
  final double inputPaddingX;
  final double inputPaddingY;
  final double inputRadius;
  final double inputFontSize;
  final double checkboxSize;
  final double switchWidth;
  final double switchHeight;
  final double sliderThumbSize;
  final double cardPadding;
  final double cardPaddingSm;
  final double cardGap;
  final double cardRadius;
  final double cardElevation;
  final double dialogPadding;
  final double dialogGap;
  final double dialogRadius;
  final double dialogElevation;
  final double menuItemPaddingX;
  final double menuItemPaddingY;
  final double menuItemRadius;
  final ShadcnTypographyTokens text;

  /// Return a copy where radius-bearing tokens scale from [baseRadius].
  ///
  /// Official shadcn themes use `0.625rem`, which is `10px` at the default
  /// browser root size. Style radii in this package are stored in that default
  /// pixel scale and can be resized while preserving the preset shape.
  ShadcnStyleTokens withBaseRadius(double baseRadius) {
    const defaultBase = 10.0;
    final scale = baseRadius / defaultBase;
    double scaled(double value) => value == 0 ? 0 : value * scale;

    return copyWith(
      buttonRadius: scaled(buttonRadius),
      inputRadius: scaled(inputRadius),
      cardRadius: scaled(cardRadius),
      dialogRadius: scaled(dialogRadius),
      menuItemRadius: scaled(menuItemRadius),
    );
  }

  /// Button height for a standard shadcn control size.
  double buttonHeightFor(ShadcnControlSize size) {
    return switch (size) {
      ShadcnControlSize.xs => buttonHeightXs,
      ShadcnControlSize.sm => buttonHeightSm,
      ShadcnControlSize.md => buttonHeight,
      ShadcnControlSize.lg => buttonHeightLg,
    };
  }

  /// Square icon button extent for a standard shadcn control size.
  double iconButtonSizeFor(ShadcnControlSize size) {
    return switch (size) {
      ShadcnControlSize.xs => buttonHeightXs,
      ShadcnControlSize.sm => buttonHeightSm,
      ShadcnControlSize.md => iconButtonSize,
      ShadcnControlSize.lg => buttonHeightLg,
    };
  }

  /// Input height for a standard shadcn control size.
  double inputHeightFor(ShadcnControlSize size) {
    return switch (size) {
      ShadcnControlSize.xs => inputHeightSm,
      ShadcnControlSize.sm => inputHeightSm,
      ShadcnControlSize.md => inputHeight,
      ShadcnControlSize.lg => inputHeight + (buttonHeightLg - buttonHeight),
    };
  }

  ShadcnStyleTokens copyWith({
    double? buttonRadius,
    double? inputRadius,
    double? cardRadius,
    double? dialogRadius,
    double? menuItemRadius,
  }) {
    return ShadcnStyleTokens(
      name: name,
      title: title,
      description: description,
      spacingUnit: spacingUnit,
      visualDensity: visualDensity,
      borderWidth: borderWidth,
      focusRingWidth: focusRingWidth,
      focusRingOpacity: focusRingOpacity,
      stateLayerOpacity: stateLayerOpacity,
      buttonHeightXs: buttonHeightXs,
      buttonHeightSm: buttonHeightSm,
      buttonHeight: buttonHeight,
      buttonHeightLg: buttonHeightLg,
      buttonPaddingX: buttonPaddingX,
      buttonGap: buttonGap,
      buttonRadius: buttonRadius ?? this.buttonRadius,
      buttonFontSize: buttonFontSize,
      buttonFontWeight: buttonFontWeight,
      buttonLetterSpacing: buttonLetterSpacing,
      uppercaseButtons: uppercaseButtons,
      iconSize: iconSize,
      iconButtonSize: iconButtonSize,
      inputHeight: inputHeight,
      inputHeightSm: inputHeightSm,
      inputPaddingX: inputPaddingX,
      inputPaddingY: inputPaddingY,
      inputRadius: inputRadius ?? this.inputRadius,
      inputFontSize: inputFontSize,
      checkboxSize: checkboxSize,
      switchWidth: switchWidth,
      switchHeight: switchHeight,
      sliderThumbSize: sliderThumbSize,
      cardPadding: cardPadding,
      cardPaddingSm: cardPaddingSm,
      cardGap: cardGap,
      cardRadius: cardRadius ?? this.cardRadius,
      cardElevation: cardElevation,
      dialogPadding: dialogPadding,
      dialogGap: dialogGap,
      dialogRadius: dialogRadius ?? this.dialogRadius,
      dialogElevation: dialogElevation,
      menuItemPaddingX: menuItemPaddingX,
      menuItemPaddingY: menuItemPaddingY,
      menuItemRadius: menuItemRadius ?? this.menuItemRadius,
      text: text,
    );
  }

  static ShadcnStyleTokens lerp(
    ShadcnStyleTokens a,
    ShadcnStyleTokens b,
    double t,
  ) {
    double mix(double left, double right) => lerpDouble(left, right, t);

    return ShadcnStyleTokens(
      name: t < 0.5 ? a.name : b.name,
      title: t < 0.5 ? a.title : b.title,
      description: t < 0.5 ? a.description : b.description,
      spacingUnit: mix(a.spacingUnit, b.spacingUnit),
      visualDensity: t < 0.5 ? a.visualDensity : b.visualDensity,
      borderWidth: mix(a.borderWidth, b.borderWidth),
      focusRingWidth: mix(a.focusRingWidth, b.focusRingWidth),
      focusRingOpacity: mix(a.focusRingOpacity, b.focusRingOpacity),
      stateLayerOpacity: mix(a.stateLayerOpacity, b.stateLayerOpacity),
      buttonHeightXs: mix(a.buttonHeightXs, b.buttonHeightXs),
      buttonHeightSm: mix(a.buttonHeightSm, b.buttonHeightSm),
      buttonHeight: mix(a.buttonHeight, b.buttonHeight),
      buttonHeightLg: mix(a.buttonHeightLg, b.buttonHeightLg),
      buttonPaddingX: mix(a.buttonPaddingX, b.buttonPaddingX),
      buttonGap: mix(a.buttonGap, b.buttonGap),
      buttonRadius: mix(a.buttonRadius, b.buttonRadius),
      buttonFontSize: mix(a.buttonFontSize, b.buttonFontSize),
      buttonFontWeight: t < 0.5 ? a.buttonFontWeight : b.buttonFontWeight,
      buttonLetterSpacing: mix(a.buttonLetterSpacing, b.buttonLetterSpacing),
      uppercaseButtons: t < 0.5 ? a.uppercaseButtons : b.uppercaseButtons,
      iconSize: mix(a.iconSize, b.iconSize),
      iconButtonSize: mix(a.iconButtonSize, b.iconButtonSize),
      inputHeight: mix(a.inputHeight, b.inputHeight),
      inputHeightSm: mix(a.inputHeightSm, b.inputHeightSm),
      inputPaddingX: mix(a.inputPaddingX, b.inputPaddingX),
      inputPaddingY: mix(a.inputPaddingY, b.inputPaddingY),
      inputRadius: mix(a.inputRadius, b.inputRadius),
      inputFontSize: mix(a.inputFontSize, b.inputFontSize),
      checkboxSize: mix(a.checkboxSize, b.checkboxSize),
      switchWidth: mix(a.switchWidth, b.switchWidth),
      switchHeight: mix(a.switchHeight, b.switchHeight),
      sliderThumbSize: mix(a.sliderThumbSize, b.sliderThumbSize),
      cardPadding: mix(a.cardPadding, b.cardPadding),
      cardPaddingSm: mix(a.cardPaddingSm, b.cardPaddingSm),
      cardGap: mix(a.cardGap, b.cardGap),
      cardRadius: mix(a.cardRadius, b.cardRadius),
      cardElevation: mix(a.cardElevation, b.cardElevation),
      dialogPadding: mix(a.dialogPadding, b.dialogPadding),
      dialogGap: mix(a.dialogGap, b.dialogGap),
      dialogRadius: mix(a.dialogRadius, b.dialogRadius),
      dialogElevation: mix(a.dialogElevation, b.dialogElevation),
      menuItemPaddingX: mix(a.menuItemPaddingX, b.menuItemPaddingX),
      menuItemPaddingY: mix(a.menuItemPaddingY, b.menuItemPaddingY),
      menuItemRadius: mix(a.menuItemRadius, b.menuItemRadius),
      text: ShadcnTypographyTokens.lerp(a.text, b.text, t),
    );
  }

  List<Object?> get _properties => [
    name,
    title,
    description,
    spacingUnit,
    visualDensity,
    borderWidth,
    focusRingWidth,
    focusRingOpacity,
    stateLayerOpacity,
    buttonHeightXs,
    buttonHeightSm,
    buttonHeight,
    buttonHeightLg,
    buttonPaddingX,
    buttonGap,
    buttonRadius,
    buttonFontSize,
    buttonFontWeight,
    buttonLetterSpacing,
    uppercaseButtons,
    iconSize,
    iconButtonSize,
    inputHeight,
    inputHeightSm,
    inputPaddingX,
    inputPaddingY,
    inputRadius,
    inputFontSize,
    checkboxSize,
    switchWidth,
    switchHeight,
    sliderThumbSize,
    cardPadding,
    cardPaddingSm,
    cardGap,
    cardRadius,
    cardElevation,
    dialogPadding,
    dialogGap,
    dialogRadius,
    dialogElevation,
    menuItemPaddingX,
    menuItemPaddingY,
    menuItemRadius,
    text,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ShadcnStyleTokens &&
            _listEquals(_properties, other._properties);
  }

  @override
  int get hashCode => Object.hashAll(_properties);

  @override
  String toString() {
    return 'ShadcnStyleTokens(name: $name, title: $title)';
  }
}

/// Typography scale used by a shadcn style preset.
class ShadcnTypographyTokens {
  const ShadcnTypographyTokens({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  final ShadcnTextStyleToken displayLarge;
  final ShadcnTextStyleToken displayMedium;
  final ShadcnTextStyleToken displaySmall;
  final ShadcnTextStyleToken headlineLarge;
  final ShadcnTextStyleToken headlineMedium;
  final ShadcnTextStyleToken headlineSmall;
  final ShadcnTextStyleToken titleLarge;
  final ShadcnTextStyleToken titleMedium;
  final ShadcnTextStyleToken titleSmall;
  final ShadcnTextStyleToken bodyLarge;
  final ShadcnTextStyleToken bodyMedium;
  final ShadcnTextStyleToken bodySmall;
  final ShadcnTextStyleToken labelLarge;
  final ShadcnTextStyleToken labelMedium;
  final ShadcnTextStyleToken labelSmall;

  TextTheme toTextTheme({
    required Color foreground,
    required Color mutedForeground,
    String? fontFamily,
  }) {
    return TextTheme(
      displayLarge: displayLarge.toTextStyle(foreground, fontFamily),
      displayMedium: displayMedium.toTextStyle(foreground, fontFamily),
      displaySmall: displaySmall.toTextStyle(foreground, fontFamily),
      headlineLarge: headlineLarge.toTextStyle(foreground, fontFamily),
      headlineMedium: headlineMedium.toTextStyle(foreground, fontFamily),
      headlineSmall: headlineSmall.toTextStyle(foreground, fontFamily),
      titleLarge: titleLarge.toTextStyle(foreground, fontFamily),
      titleMedium: titleMedium.toTextStyle(foreground, fontFamily),
      titleSmall: titleSmall.toTextStyle(foreground, fontFamily),
      bodyLarge: bodyLarge.toTextStyle(foreground, fontFamily),
      bodyMedium: bodyMedium.toTextStyle(foreground, fontFamily),
      bodySmall: bodySmall.toTextStyle(mutedForeground, fontFamily),
      labelLarge: labelLarge.toTextStyle(foreground, fontFamily),
      labelMedium: labelMedium.toTextStyle(foreground, fontFamily),
      labelSmall: labelSmall.toTextStyle(mutedForeground, fontFamily),
    );
  }

  static ShadcnTypographyTokens lerp(
    ShadcnTypographyTokens a,
    ShadcnTypographyTokens b,
    double t,
  ) {
    return ShadcnTypographyTokens(
      displayLarge: ShadcnTextStyleToken.lerp(
        a.displayLarge,
        b.displayLarge,
        t,
      ),
      displayMedium: ShadcnTextStyleToken.lerp(
        a.displayMedium,
        b.displayMedium,
        t,
      ),
      displaySmall: ShadcnTextStyleToken.lerp(
        a.displaySmall,
        b.displaySmall,
        t,
      ),
      headlineLarge: ShadcnTextStyleToken.lerp(
        a.headlineLarge,
        b.headlineLarge,
        t,
      ),
      headlineMedium: ShadcnTextStyleToken.lerp(
        a.headlineMedium,
        b.headlineMedium,
        t,
      ),
      headlineSmall: ShadcnTextStyleToken.lerp(
        a.headlineSmall,
        b.headlineSmall,
        t,
      ),
      titleLarge: ShadcnTextStyleToken.lerp(a.titleLarge, b.titleLarge, t),
      titleMedium: ShadcnTextStyleToken.lerp(a.titleMedium, b.titleMedium, t),
      titleSmall: ShadcnTextStyleToken.lerp(a.titleSmall, b.titleSmall, t),
      bodyLarge: ShadcnTextStyleToken.lerp(a.bodyLarge, b.bodyLarge, t),
      bodyMedium: ShadcnTextStyleToken.lerp(a.bodyMedium, b.bodyMedium, t),
      bodySmall: ShadcnTextStyleToken.lerp(a.bodySmall, b.bodySmall, t),
      labelLarge: ShadcnTextStyleToken.lerp(a.labelLarge, b.labelLarge, t),
      labelMedium: ShadcnTextStyleToken.lerp(a.labelMedium, b.labelMedium, t),
      labelSmall: ShadcnTextStyleToken.lerp(a.labelSmall, b.labelSmall, t),
    );
  }

  List<Object?> get _properties => [
    displayLarge,
    displayMedium,
    displaySmall,
    headlineLarge,
    headlineMedium,
    headlineSmall,
    titleLarge,
    titleMedium,
    titleSmall,
    bodyLarge,
    bodyMedium,
    bodySmall,
    labelLarge,
    labelMedium,
    labelSmall,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ShadcnTypographyTokens &&
            _listEquals(_properties, other._properties);
  }

  @override
  int get hashCode => Object.hashAll(_properties);

  @override
  String toString() => 'ShadcnTypographyTokens()';
}

/// A single text style token.
class ShadcnTextStyleToken {
  const ShadcnTextStyleToken({
    required this.fontSize,
    required this.lineHeight,
    required this.fontWeight,
    this.letterSpacing = 0,
  });

  final double fontSize;
  final double lineHeight;
  final FontWeight fontWeight;
  final double letterSpacing;

  TextStyle toTextStyle(Color color, String? fontFamily) {
    return TextStyle(
      color: color,
      fontFamily: fontFamily,
      fontSize: fontSize,
      height: lineHeight / fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    );
  }

  static ShadcnTextStyleToken lerp(
    ShadcnTextStyleToken a,
    ShadcnTextStyleToken b,
    double t,
  ) {
    return ShadcnTextStyleToken(
      fontSize: lerpDouble(a.fontSize, b.fontSize, t),
      lineHeight: lerpDouble(a.lineHeight, b.lineHeight, t),
      fontWeight: t < 0.5 ? a.fontWeight : b.fontWeight,
      letterSpacing: lerpDouble(a.letterSpacing, b.letterSpacing, t),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ShadcnTextStyleToken &&
            fontSize == other.fontSize &&
            lineHeight == other.lineHeight &&
            fontWeight == other.fontWeight &&
            letterSpacing == other.letterSpacing;
  }

  @override
  int get hashCode {
    return Object.hash(fontSize, lineHeight, fontWeight, letterSpacing);
  }

  @override
  String toString() {
    return 'ShadcnTextStyleToken(fontSize: $fontSize, lineHeight: $lineHeight)';
  }
}

double lerpDouble(double a, double b, double t) => a + (b - a) * t;

bool _listEquals(List<Object?> a, List<Object?> b) {
  if (identical(a, b)) {
    return true;
  }
  if (a.length != b.length) {
    return false;
  }
  for (var i = 0; i < a.length; i += 1) {
    if (a[i] != b[i]) {
      return false;
    }
  }
  return true;
}
