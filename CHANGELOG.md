## 0.0.8

- Added a runnable Flutter example app that switches shadcn color themes,
  style presets, and brightness.
- Expanded README usage documentation for `ThemeData` accessors, examples, and
  token update docs.
- Added documentation tests to keep the README and example app present.

## 0.0.7

- Added the public `ShadcnColorTokens.semanticTokenNames` and
  `semanticTokenCount` contract for generated color maps.
- Added token generation documentation covering upstream source data, accent
  theme merging, style token scope, and validation rules.
- Added unit coverage to verify every light and dark theme exposes all 31
  semantic color tokens.

## 0.0.6

- Added `ShadcnThemeData.resolve` for brightness-driven theme construction.
- Added `ThemeData.shadcnTheme`, `ThemeData.maybeShadcnTheme`, and matching
  `BuildContext` accessors for safer token reads.
- Added unit coverage for extension access, copyWith, and interpolation.

## 0.0.5

- Mapped control height tokens into button fixed sizes and input constraints.
- Added component theme regression coverage for button sizing, input sizing,
  shape radii, borders, switches, sliders, and progress indicators.

## 0.0.4

- Added `ShadcnControlSize` and style token helpers for button, icon button,
  and input dimensions.
- Added unit coverage for compact, rounded, and editorial style sizing.

## 0.0.3

- Added source metadata and base/accent theme classification helpers.
- Expanded color token regression coverage across base themes, accent themes,
  light/dark values, neutral-base merging, and alpha colors.

## 0.0.2

- Added value semantics and debug strings for theme, color, radius, style,
  typography, and theme extension token classes.
- Added unit coverage for registry lookups, token equality, hash stability, and
  debug output.

## 0.0.1

- Replaced the template package API with a theme-only shadcn Flutter API.
- Added 24 official shadcn color themes with light and dark semantic tokens.
- Added 7 official shadcn style presets covering sizing, spacing, radius,
  typography, borders, shadows, and state layers.
- Added `ShadcnThemeData.light` and `ShadcnThemeData.dark` factories.
- Added `ShadcnThemeExtension` for reading active tokens from `ThemeData`.
- Added unit tests for registry completeness, representative token values,
  `ThemeData` generation, radius scaling, and style differences.
