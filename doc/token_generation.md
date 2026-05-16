# Token Generation

`shadcn_theme` is a theme-only package. It does not ship widgets, component
wrappers, or runtime code generation.

## Color Source

Color tokens are generated from the official shadcn registry:

https://github.com/shadcn-ui/ui/blob/main/apps/v4/registry/themes.ts

The generated Dart registry lives in `lib/src/shadcn_theme_registry.dart`.
Accent themes are stored after they have been merged with the official neutral
base theme so every published theme exposes a complete semantic token set.

Each light or dark color token set exposes 31 semantic CSS variable names. The
public contract is `ShadcnColorTokens.semanticTokenNames`, and `toMap()` must
return exactly those keys.

## Style Tokens

Style presets are translated into Flutter design tokens in
`lib/src/shadcn_style_registry.dart`. They cover non-color theme decisions:

- control heights
- control padding
- icon sizes
- typography
- border width
- focus ring width and opacity
- state layer opacity
- radii
- spacing
- elevations

This package intentionally maps those tokens into Flutter `ThemeData` instead
of wrapping Material widgets.

## Update Rules

1. Update generated values only from upstream source data.
2. Keep accent themes pre-merged with `ShadcnThemes.defaultBaseTheme`.
3. Preserve the 31-key semantic color contract unless upstream shadcn changes
   the token model.
4. Run `dart format lib test example/lib example/test`.
5. Run `dart analyze`.
6. Run `dart analyze` in `example`.
7. Run `flutter test --test-randomize-ordering-seed=random`.
8. Run `flutter test --test-randomize-ordering-seed=random` in `example`.
9. Run `flutter pub publish --dry-run`.

Any upstream token change should include regression tests for representative
light and dark values.
