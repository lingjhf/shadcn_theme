# Release Checklist

This package is released through GitHub Actions when a version tag is pushed.
For validation-only iterations, do not push tags.

Before any release commit:

1. Review the package API, tests, docs, metadata, and CI changes.
2. Update `pubspec.yaml`.
3. Add the matching top entry to `CHANGELOG.md`.
4. Run `dart format --output=none --set-exit-if-changed lib test example/lib example/test`.
5. Run `git diff --check`.
6. Run `dart analyze`.
7. Run `dart analyze` in `example`.
8. Run `flutter test --test-randomize-ordering-seed=random`.
9. Run `flutter test --test-randomize-ordering-seed=random` in `example`.
10. Run `flutter pub publish --dry-run`.

Only publish by pushing a version tag after pub.dev automated publishing is
configured and the current iteration explicitly requires publishing.
