import 'package:flutter/material.dart';

import 'shadcn_style_tokens.dart';
import 'shadcn_theme_tokens.dart';

/// Theme extension that keeps the complete shadcn token set in [ThemeData].
class ShadcnThemeExtension extends ThemeExtension<ShadcnThemeExtension> {
  const ShadcnThemeExtension({
    required this.theme,
    required this.colors,
    required this.style,
    required this.radius,
  });

  /// Complete light/dark theme tokens.
  final ShadcnThemeTokens theme;

  /// Active brightness-specific color tokens.
  final ShadcnColorTokens colors;

  /// Active style preset tokens.
  final ShadcnStyleTokens style;

  /// Active radius scale.
  final ShadcnRadiusScale radius;

  @override
  ShadcnThemeExtension copyWith({
    ShadcnThemeTokens? theme,
    ShadcnColorTokens? colors,
    ShadcnStyleTokens? style,
    ShadcnRadiusScale? radius,
  }) {
    return ShadcnThemeExtension(
      theme: theme ?? this.theme,
      colors: colors ?? this.colors,
      style: style ?? this.style,
      radius: radius ?? this.radius,
    );
  }

  @override
  ShadcnThemeExtension lerp(
    covariant ThemeExtension<ShadcnThemeExtension>? other,
    double t,
  ) {
    if (other is! ShadcnThemeExtension) {
      return this;
    }
    return ShadcnThemeExtension(
      theme: t < 0.5 ? theme : other.theme,
      colors: ShadcnColorTokens.lerp(colors, other.colors, t),
      style: ShadcnStyleTokens.lerp(style, other.style, t),
      radius: ShadcnRadiusScale(
        radius.base + (other.radius.base - radius.base) * t,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ShadcnThemeExtension &&
            theme == other.theme &&
            colors == other.colors &&
            style == other.style &&
            radius == other.radius;
  }

  @override
  int get hashCode => Object.hash(theme, colors, style, radius);

  @override
  String toString() {
    return 'ShadcnThemeExtension(theme: ${theme.name}, style: ${style.name})';
  }
}

extension ShadcnThemeContext on BuildContext {
  /// Read the active shadcn theme extension from [ThemeData].
  ShadcnThemeExtension get shadcnTheme {
    final extension = Theme.of(this).extension<ShadcnThemeExtension>();
    assert(
      extension != null,
      'No ShadcnThemeExtension found. Use ShadcnThemeData.light/dark.',
    );
    return extension!;
  }
}
