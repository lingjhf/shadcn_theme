import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('pubspec version, changelog, and release checklist stay aligned', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final changelog = File('CHANGELOG.md').readAsStringSync();
    final checklist = File('doc/release_checklist.md').readAsStringSync();

    final version = RegExp(
      r'^version:\s*(\S+)$',
      multiLine: true,
    ).firstMatch(pubspec)!.group(1);
    final changelogVersion = RegExp(
      r'^##\s+(\S+)$',
      multiLine: true,
    ).firstMatch(changelog)!.group(1);

    expect(version, '0.1.10');
    expect(changelogVersion, version);
    expect(checklist, contains('do not push tags'));
    expect(checklist, contains('flutter pub publish --dry-run'));
  });
}
