import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('README documents the public setup and example app', () {
    final readme = File('README.md').readAsStringSync();

    expect(readme, contains('ShadcnThemeData.light'));
    expect(readme, contains('context.shadcnTheme'));
    expect(readme, contains('maybeShadcnTheme'));
    expect(readme, contains('ShadcnThemeNames.parse'));
    expect(readme, contains("colors.get('sidebar')"));
    expect(readme, contains('cardPaddingInsets'));
    expect(readme, contains('example/'));
    expect(readme, contains('flutter test'));
    expect(readme, contains('doc/token_generation.md'));
    expect(readme, contains('doc/api_contract.md'));
    expect(readme, contains('doc/release_checklist.md'));
  });

  test('example app is present for pub.dev and local smoke testing', () {
    expect(File('example/pubspec.yaml').existsSync(), isTrue);
    expect(File('example/lib/main.dart').existsSync(), isTrue);
    expect(File('example/test/example_app_test.dart').existsSync(), isTrue);
  });
}
