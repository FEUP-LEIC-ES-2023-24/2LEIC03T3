import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:project_es/screens/Map.dart';

void main() {
  group('MapScreen', () {
    testWidgets('displays AppBar with correct attributes', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MapScreen()));

      final appBar = find.byType(AppBar);
      expect(appBar, findsOneWidget);

      final appBarTitle = find.descendant(of: appBar, matching: find.text('DigiWater'));
      expect(appBarTitle, findsOneWidget);
    });

    testWidgets('displays specific Center widget', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MapScreen()));

      // Find the specific Center widget containing the text 'Map Screen'
      final centerText = find.text('Map Screen');
      expect(centerText, findsOneWidget);

      // Ensure that the parent of this text widget is a Center widget
      final centerWidget = find.ancestor(of: centerText, matching: find.byType(Center));
      expect(centerWidget, findsOneWidget);
    });

    testWidgets('displays correct text within Center widget', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MapScreen()));

      final centerText = find.text('Map Screen');
      expect(centerText, findsOneWidget);
    });
  });
}
