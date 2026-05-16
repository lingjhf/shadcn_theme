import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_theme/shadcn_theme.dart';

void main() {
  test('package library exposes the production theme entry points', () {
    final theme = ShadcnThemeData.resolve(
      brightness: Brightness.dark,
      theme: ShadcnThemeName.sky,
      style: ShadcnStyleName.vega,
      radius: 12,
      fontFamily: 'Inter',
    );
    final extension = theme.shadcnTheme;

    expect(theme.brightness, Brightness.dark);
    expect(extension.theme.name, ShadcnThemeName.sky);
    expect(extension.style.name, ShadcnStyleName.vega);
    expect(extension.radius.base, 12);
    expect(extension.brightness, Brightness.dark);
    expect(extension.fontFamily, 'Inter');
    expect(theme.textTheme.bodyMedium?.fontFamily, 'Inter');
    expect(
      ShadcnThemes.all,
      containsPair(ShadcnThemeName.sky, extension.theme),
    );
    expect(ShadcnStyles.all[ShadcnStyleName.vega]?.name, extension.style.name);
  });

  test('public name helpers parse stable ids for app configuration', () {
    expect(ShadcnThemeNames.tryParse('sky'), ShadcnThemeName.sky);
    expect(ShadcnThemeNames.parse('zinc'), ShadcnThemeName.zinc);
    expect(ShadcnThemeNames.tryParse('unknown'), isNull);
    expect(() => ShadcnThemeNames.parse('unknown'), throwsArgumentError);

    expect(ShadcnStyleNames.tryParse('nova'), ShadcnStyleName.nova);
    expect(ShadcnStyleNames.parse('luma'), ShadcnStyleName.luma);
    expect(ShadcnStyleNames.tryParse('unknown'), isNull);
    expect(() => ShadcnStyleNames.parse('unknown'), throwsArgumentError);
    expect(ShadcnThemeNames.byId.keys, containsAll(['neutral', 'yellow']));
    expect(ShadcnStyleNames.byId.keys, containsAll(['vega', 'sera']));
  });

  test('public docs define theme-only scope and validation contract', () {
    final apiContract = File('doc/api_contract.md').readAsStringSync();
    final library = File('lib/shadcn_theme.dart').readAsStringSync();

    expect(library, contains("export 'src/shadcn_theme_data.dart';"));
    expect(apiContract, contains('theme-only Flutter package'));
    expect(apiContract, contains('ShadcnThemeData.resolve'));
    expect(apiContract, contains('ThemeData.shadcnTheme'));
    expect(apiContract, contains('flutter pub publish --dry-run'));
  });
}
