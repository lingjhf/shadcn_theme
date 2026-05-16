# API Contract

`shadcn_theme` 0.1.x is a theme-only Flutter package. It provides tokens and
Flutter `ThemeData` mapping, not widgets.

## Public Surface

The public library is `package:shadcn_theme/shadcn_theme.dart`.

Stable 0.1.x entry points:

- `ShadcnThemeData.light`
- `ShadcnThemeData.dark`
- `ShadcnThemeData.resolve`
- `ShadcnThemeName`
- `ShadcnStyleName`
- `ShadcnThemes`
- `ShadcnStyles`
- `ShadcnThemeExtension`
- `ShadcnColorTokens`
- `ShadcnStyleTokens`
- `BuildContext.shadcnTheme`
- `BuildContext.maybeShadcnTheme`
- `ThemeData.shadcnTheme`
- `ThemeData.maybeShadcnTheme`

## Non-Goals

This package intentionally does not expose Flutter component wrappers. Apps
should use Flutter Material widgets, their own components, or another component
library and consume this package for theme data and tokens.

## Compatibility

Within 0.1.x, patch releases should preserve:

- enum values for published themes and style presets
- the 31-key `ShadcnColorTokens.semanticTokenNames` contract
- `ThemeData` factory signatures
- token access through `ThemeData` and `BuildContext`
- generated theme source metadata

Breaking changes should be reserved for a new minor version while the package is
pre-1.0.0.

## Validation

Every release should pass:

- `dart format --output=none --set-exit-if-changed lib test example/lib`
- `git diff --check`
- `dart analyze`
- `dart analyze` in `example`
- `flutter test --test-randomize-ordering-seed=random`
- `flutter pub publish --dry-run`
