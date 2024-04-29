import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:project_es/screens/Map.dart';

void main() {
  group('MapScreen', () {
    testWidgets('displays AppBar with correct attributes', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MapScreen()));

      final appBar = find.byType(AppBar);
      expect(appBar, findsOneWidget);

      final Text title = tester.widget(find.descendant(of: appBar, matching: find.byType(Text)));
      expect(title.data, 'Map');
    });

    testWidgets('displays Center widget', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MapScreen()));

      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('displays correct text within Center widget', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MapScreen()));

      final Text centerText = tester.widget(find.descendant(of: find.byType(Center), matching: find.byType(Text)));
      expect(centerText.data, 'Map Screen');
    });
  });
}