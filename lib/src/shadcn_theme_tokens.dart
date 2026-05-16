import 'package:flutter/material.dart';

import 'shadcn_names.dart';

/// A complete shadcn color theme with light and dark semantic tokens.
class ShadcnThemeTokens {
  const ShadcnThemeTokens({
    required this.name,
    required this.title,
    required this.radius,
    required this.light,
    required this.dark,
  });

  /// Theme registry id.
  final ShadcnThemeName name;

  /// Human-readable theme name.
  final String title;

  /// Base radius in Flutter logical pixels.
  final double radius;

  /// Light mode semantic color tokens.
  final ShadcnColorTokens light;

  /// Dark mode semantic color tokens.
  final ShadcnColorTokens dark;

  /// Return tokens for [brightness].
  ShadcnColorTokens colorsFor(Brightness brightness) {
    return brightness == Brightness.dark ? dark : light;
  }

  /// Derived radius scale matching shadcn's CSS variable convention.
  ShadcnRadiusScale radiusScale([double? override]) {
    return ShadcnRadiusScale(override ?? radius);
  }
}

/// shadcn's semantic color token set for one brightness.
class ShadcnColorTokens {
  const ShadcnColorTokens({
    required this.background,
    required this.foreground,
    required this.card,
    required this.cardForeground,
    required this.popover,
    required this.popoverForeground,
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryForeground,
    required this.muted,
    required this.mutedForeground,
    required this.accent,
    required this.accentForeground,
    required this.destructive,
    required this.border,
    required this.input,
    required this.ring,
    required this.chart1,
    required this.chart2,
    required this.chart3,
    required this.chart4,
    required this.chart5,
    required this.sidebar,
    required this.sidebarForeground,
    required this.sidebarPrimary,
    required this.sidebarPrimaryForeground,
    required this.sidebarAccent,
    required this.sidebarAccentForeground,
    required this.sidebarBorder,
    required this.sidebarRing,
  });

  final Color background;
  final Color foreground;
  final Color card;
  final Color cardForeground;
  final Color popover;
  final Color popoverForeground;
  final Color primary;
  final Color primaryForeground;
  final Color secondary;
  final Color secondaryForeground;
  final Color muted;
  final Color mutedForeground;
  final Color accent;
  final Color accentForeground;
  final Color destructive;
  final Color border;
  final Color input;
  final Color ring;
  final Color chart1;
  final Color chart2;
  final Color chart3;
  final Color chart4;
  final Color chart5;
  final Color sidebar;
  final Color sidebarForeground;
  final Color sidebarPrimary;
  final Color sidebarPrimaryForeground;
  final Color sidebarAccent;
  final Color sidebarAccentForeground;
  final Color sidebarBorder;
  final Color sidebarRing;

  List<Color> get charts => [chart1, chart2, chart3, chart4, chart5];

  Map<String, Color> toMap() {
    return {
      'background': background,
      'foreground': foreground,
      'card': card,
      'card-foreground': cardForeground,
      'popover': popover,
      'popover-foreground': popoverForeground,
      'primary': primary,
      'primary-foreground': primaryForeground,
      'secondary': secondary,
      'secondary-foreground': secondaryForeground,
      'muted': muted,
      'muted-foreground': mutedForeground,
      'accent': accent,
      'accent-foreground': accentForeground,
      'destructive': destructive,
      'border': border,
      'input': input,
      'ring': ring,
      'chart-1': chart1,
      'chart-2': chart2,
      'chart-3': chart3,
      'chart-4': chart4,
      'chart-5': chart5,
      'sidebar': sidebar,
      'sidebar-foreground': sidebarForeground,
      'sidebar-primary': sidebarPrimary,
      'sidebar-primary-foreground': sidebarPrimaryForeground,
      'sidebar-accent': sidebarAccent,
      'sidebar-accent-foreground': sidebarAccentForeground,
      'sidebar-border': sidebarBorder,
      'sidebar-ring': sidebarRing,
    };
  }

  static ShadcnColorTokens lerp(
    ShadcnColorTokens a,
    ShadcnColorTokens b,
    double t,
  ) {
    Color mix(Color left, Color right) => Color.lerp(left, right, t)!;

    return ShadcnColorTokens(
      background: mix(a.background, b.background),
      foreground: mix(a.foreground, b.foreground),
      card: mix(a.card, b.card),
      cardForeground: mix(a.cardForeground, b.cardForeground),
      popover: mix(a.popover, b.popover),
      popoverForeground: mix(a.popoverForeground, b.popoverForeground),
      primary: mix(a.primary, b.primary),
      primaryForeground: mix(a.primaryForeground, b.primaryForeground),
      secondary: mix(a.secondary, b.secondary),
      secondaryForeground: mix(a.secondaryForeground, b.secondaryForeground),
      muted: mix(a.muted, b.muted),
      mutedForeground: mix(a.mutedForeground, b.mutedForeground),
      accent: mix(a.accent, b.accent),
      accentForeground: mix(a.accentForeground, b.accentForeground),
      destructive: mix(a.destructive, b.destructive),
      border: mix(a.border, b.border),
      input: mix(a.input, b.input),
      ring: mix(a.ring, b.ring),
      chart1: mix(a.chart1, b.chart1),
      chart2: mix(a.chart2, b.chart2),
      chart3: mix(a.chart3, b.chart3),
      chart4: mix(a.chart4, b.chart4),
      chart5: mix(a.chart5, b.chart5),
      sidebar: mix(a.sidebar, b.sidebar),
      sidebarForeground: mix(a.sidebarForeground, b.sidebarForeground),
      sidebarPrimary: mix(a.sidebarPrimary, b.sidebarPrimary),
      sidebarPrimaryForeground: mix(
        a.sidebarPrimaryForeground,
        b.sidebarPrimaryForeground,
      ),
      sidebarAccent: mix(a.sidebarAccent, b.sidebarAccent),
      sidebarAccentForeground: mix(
        a.sidebarAccentForeground,
        b.sidebarAccentForeground,
      ),
      sidebarBorder: mix(a.sidebarBorder, b.sidebarBorder),
      sidebarRing: mix(a.sidebarRing, b.sidebarRing),
    );
  }
}

/// Derived radius tokens matching shadcn's default CSS scale.
class ShadcnRadiusScale {
  const ShadcnRadiusScale(this.base);

  /// Same as shadcn's `--radius` / `--radius-lg`.
  final double base;

  double get none => 0;
  double get sm => base * 0.6;
  double get md => base * 0.8;
  double get lg => base;
  double get xl => base * 1.4;
  double get x2l => base * 1.8;
  double get x3l => base * 2.2;
  double get x4l => base * 2.6;

  BorderRadius borderRadius(double value) => BorderRadius.circular(value);
}
