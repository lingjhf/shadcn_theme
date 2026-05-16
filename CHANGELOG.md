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
