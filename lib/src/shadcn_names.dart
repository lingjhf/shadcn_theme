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

extension ShadcnThemeNameInfo on ShadcnThemeName {
  /// Registry-safe theme id.
  String get id => name;

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
