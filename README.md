# shadcn_theme

A theme-only Flutter package for shadcn color themes and style presets.

This package does not ship or wrap any components. It provides token registries,
`ThemeData` factories, and a `ThemeExtension` so your own Flutter widgets can use
shadcn-inspired colors, typography, spacing, radius, density, borders, shadows,
and state layers.

## Features

- 24 official shadcn color themes.
- 7 official shadcn style presets: Vega, Nova, Maia, Lyra, Mira, Luma, and Sera.
- Light and dark `ThemeData` factories.
- Complete token access for chart and sidebar colors.
- `ThemeData` and `BuildContext` token accessors.
- Example Flutter app under `example/`.
- No runtime network requests and no npm dependency.

Color values are generated from the official shadcn `apps/v4/registry/themes.ts`
source. Accent-style themes such as `blue` and `amber` are pre-merged with the
official default `neutral` base color.

shadcn/ui is MIT licensed; this package keeps its generated token data static so
apps do not need the JavaScript registry at runtime.

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:shadcn_theme/shadcn_theme.dart';

MaterialApp(
  theme: ShadcnThemeData.light(
    theme: ShadcnThemeName.zinc,
    style: ShadcnStyleName.nova,
  ),
  darkTheme: ShadcnThemeData.dark(
    theme: ShadcnThemeName.zinc,
    style: ShadcnStyleName.nova,
  ),
  home: const MyApp(),
);
```

Override the base radius while keeping the selected style's shape ratios:

```dart
final theme = ShadcnThemeData.light(
  theme: ShadcnThemeName.emerald,
  style: ShadcnStyleName.luma,
  radius: 14,
);
```

Read tokens from the active theme:

```dart
final shadcn = context.shadcnTheme;
final optional = Theme.of(context).maybeShadcnTheme;
final chartColors = shadcn.colors.charts;
final sidebarBackground = shadcn.colors.sidebar;
final cardPadding = shadcn.style.cardPadding;
```

Read tokens without a `BuildContext`:

```dart
final tokens = ShadcnThemeName.blue.tokens.light;
final styles = ShadcnStyleName.mira.tokens;
```

## Example

Run the bundled example app:

```bash
cd example
flutter run
```

The example switches color themes, style presets, and brightness while using the
same package API that applications consume.

## Token Updates

Generated token maintenance rules are documented in
[`doc/token_generation.md`](doc/token_generation.md).

The 0.1.x public API contract is documented in
[`doc/api_contract.md`](doc/api_contract.md).

## Scope

This package intentionally does not implement shadcn widgets. Use Flutter,
Material, or your own components and let this package supply the design system
tokens and Flutter theme mapping.
