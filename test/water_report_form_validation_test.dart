import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:project_es/screens/ReportCreation.dart';

void main() {
  testWidgets('WaterReportForm displays validation errors for required fields', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: WaterReportForm()));

    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    expect(find.text('Please enter location name'), findsOneWidget);
    expect(find.text('Please enter coordinates'), findsOneWidget);
  });
}
