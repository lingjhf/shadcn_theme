#!/usr/bin/env sh
set -eu

flutter pub get
dart analyze
flutter test --test-randomize-ordering-seed=random
flutter pub publish --dry-run
git diff --check
