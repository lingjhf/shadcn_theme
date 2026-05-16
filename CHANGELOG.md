## 0.1.5

- Added active `brightness` and `fontFamily` context to
  `ShadcnThemeExtension`.
- Expanded extension tests for ThemeData construction, copyWith clearing, and
  interpolation semantics.

## 0.1.4

- Added `ShadcnColorTokens.tryGet` and `get` for safe lookup by semantic token
  name.
- Expanded color/source tests for token lookup, source metadata, base/accent
  disjointness, and accent theme neutral-base merging.

## 0.1.3

- Added semantic `EdgeInsets` helpers for button, input, card, dialog, and
  menu item padding on `ShadcnStyleTokens`.
- Updated ThemeData mappings to reuse style padding helpers and added
  regression tests for those derived spacing values.

## 0.1.2

- Mapped shadcn tokens into additional Material themes for text selection,
  dropdown menus, floating action buttons, navigation bars, and snack bars.
- Added regression coverage for extended component color, size, and state
  mappings.

## 0.1.1

- Added public `ShadcnThemeNames` and `ShadcnStyleNames` lookup helpers for
  parsing stable theme and style ids from app configuration.
- Added public API tests for successful and failed theme/style id parsing.

## 0.1.0

- Documented the 0.1.x public API contract for production use.
- Added public API regression tests covering theme factories, token registries,
  `ThemeData` accessors, font overrides, and release validation docs.

## 0.0.10

- Added pub.dev topics for Flutter, theming, shadcn, Material, and design
  system discovery.
- Expanded package metadata tests to cover the current version and discoverable
  topic metadata.

## 0.0.9

- Hardened CI and publish workflows with formatting checks, whitespace checks,
  and independent example analysis.
- Added package metadata and GitHub Actions regression tests for the pub.dev
  automated publishing path.

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
