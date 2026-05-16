import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_theme_example/main.dart';

void main() {
  testWidgets('example app renders theme controls and toggles brightness', (
    tester,
  ) async {
    await tester.pumpWidget(const ShadcnThemeExampleApp());

    expect(find.text('shadcn_theme'), findsOneWidget);
    expect(find.text('Zinc / Nova'), findsOneWidget);
    expect(find.text('Primary'), findsOneWidget);
    expect(find.byTooltip('Toggle brightness'), findsOneWidget);

    await tester.tap(find.byTooltip('Toggle brightness'));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.light_mode), findsOneWidget);
  });
}
