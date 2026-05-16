import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('pubspec contains required pub.dev package metadata', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();

    expect(pubspec, contains('name: shadcn_theme'));
    expect(pubspec, contains('description:'));
    expect(
      pubspec,
      contains('repository: https://github.com/lingjhf/shadcn_theme'),
    );
    expect(
      pubspec,
      contains('issue_tracker: https://github.com/lingjhf/shadcn_theme/issues'),
    );
    expect(pubspec, contains('version: 0.1.1'));
    expect(pubspec, contains('topics:'));
    expect(pubspec, contains('  - flutter'));
    expect(pubspec, contains('  - shadcn'));
    expect(pubspec, contains('  - design-system'));
  });

  test('github workflows validate and publish through pub.dev automation', () {
    final ci = File('.github/workflows/ci.yml').readAsStringSync();
    final publish = File('.github/workflows/publish.yml').readAsStringSync();

    for (final workflow in [ci, publish]) {
      expect(workflow, contains('dart format --output=none'));
      expect(workflow, contains('git diff --check'));
      expect(
        workflow,
        contains('flutter test --test-randomize-ordering-seed=random'),
      );
      expect(workflow, contains('flutter pub publish --dry-run'));
      expect(workflow, contains('working-directory: example'));
    }
    expect(publish, contains('id-token: write'));
    expect(publish, contains('flutter pub publish --force'));
    expect(publish, contains("tags:"));
    expect(publish, contains("'[0-9]*.[0-9]*.[0-9]*'"));
  });
}
