/// Official shadcn color themes supported by this package.
enum ShadcnThemeName {
  neutral,
  stone,
  zinc,
  mauve,
  olive,
  mist,
  taupe,
  amber,
  blue,
  cyan,
  emerald,
  fuchsia,
  green,
  indigo,
  lime,
  orange,
  pink,
  purple,
  red,
  rose,
  sky,
  teal,
  violet,
  yellow,
}

/// Official shadcn style presets supported by this package.
enum ShadcnStyleName { vega, nova, maia, lyra, mira, luma, sera }

/// Lookup helpers for public shadcn color theme names.
abstract final class ShadcnThemeNames {
  static final Map<String, ShadcnThemeName> byId = {
    for (final theme in ShadcnThemeName.values) theme.id: theme,
  };

  /// Return the theme for [id], or null when the id is unknown.
  static ShadcnThemeName? tryParse(String id) => byId[id];

  /// Return the theme for [id].
  ///
  /// Throws [ArgumentError] when [id] is not a supported shadcn theme id.
  static ShadcnThemeName parse(String id) {
    final theme = tryParse(id);
    if (theme == null) {
      throw ArgumentError.value(id, 'id', 'Unsupported shadcn theme id');
    }
    return theme;
  }
}

/// Lookup helpers for public shadcn style preset names.
abstract final class ShadcnStyleNames {
  static final Map<String, ShadcnStyleName> byId = {
    for (final style in ShadcnStyleName.values) style.id: style,
  };

  /// Return the style preset for [id], or null when the id is unknown.
  static ShadcnStyleName? tryParse(String id) => byId[id];

  /// Return the style preset for [id].
  ///
  /// Throws [ArgumentError] when [id] is not a supported shadcn style id.
  static ShadcnStyleName parse(String id) {
    final style = tryParse(id);
    if (style == null) {
      throw ArgumentError.value(id, 'id', 'Unsupported shadcn style id');
    }
    return style;
  }
}

extension ShadcnThemeNameInfo on ShadcnThemeName {
  static const Set<ShadcnThemeName> baseColorThemes = {
    ShadcnThemeName.neutral,
    ShadcnThemeName.stone,
    ShadcnThemeName.zinc,
    ShadcnThemeName.mauve,
    ShadcnThemeName.olive,
    ShadcnThemeName.mist,
    ShadcnThemeName.taupe,
  };

  /// Registry-safe theme id.
  String get id => name;

  /// Whether this theme is one of shadcn's complete base color themes.
  bool get isBaseColorTheme => baseColorThemes.contains(this);

  /// Whether this theme is an accent theme pre-merged with the neutral base.
  bool get isAccentTheme => !isBaseColorTheme;

  /// Human-readable label.
  String get label => switch (this) {
    ShadcnThemeName.neutral => 'Neutral',
    ShadcnThemeName.stone => 'Stone',
    ShadcnThemeName.zinc => 'Zinc',
    ShadcnThemeName.mauve => 'Mauve',
    ShadcnThemeName.olive => 'Olive',
    ShadcnThemeName.mist => 'Mist',
    ShadcnThemeName.taupe => 'Taupe',
    ShadcnThemeName.amber => 'Amber',
    ShadcnThemeName.blue => 'Blue',
    ShadcnThemeName.cyan => 'Cyan',
    ShadcnThemeName.emerald => 'Emerald',
    ShadcnThemeName.fuchsia => 'Fuchsia',
    ShadcnThemeName.green => 'Green',
    ShadcnThemeName.indigo => 'Indigo',
    ShadcnThemeName.lime => 'Lime',
    ShadcnThemeName.orange => 'Orange',
    ShadcnThemeName.pink => 'Pink',
    ShadcnThemeName.purple => 'Purple',
    ShadcnThemeName.red => 'Red',
    ShadcnThemeName.rose => 'Rose',
    ShadcnThemeName.sky => 'Sky',
    ShadcnThemeName.teal => 'Teal',
    ShadcnThemeName.violet => 'Violet',
    ShadcnThemeName.yellow => 'Yellow',
  };
}

extension ShadcnStyleNameInfo on ShadcnStyleName {
  /// Registry-safe style id.
  String get id => name;

  /// Human-readable label.
  String get label => switch (this) {
    ShadcnStyleName.vega => 'Vega',
    ShadcnStyleName.nova => 'Nova',
    ShadcnStyleName.maia => 'Maia',
    ShadcnStyleName.lyra => 'Lyra',
    ShadcnStyleName.mira => 'Mira',
    ShadcnStyleName.luma => 'Luma',
    ShadcnStyleName.sera => 'Sera',
  };
}
