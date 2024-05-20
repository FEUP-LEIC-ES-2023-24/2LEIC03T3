import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:project_es/screens/ReportCreation.dart';

void main() {
  testWidgets('WaterReportForm toggles potable and swimmingSuitable checkboxes', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: WaterReportForm()));

    // Verify initial state of checkboxes
    expect(find.byType(CheckboxListTile), findsNWidgets(2));
    expect(tester.widget<CheckboxListTile>(find.widgetWithText(CheckboxListTile, 'Potable')).value, false);
    expect(tester.widget<CheckboxListTile>(find.widgetWithText(CheckboxListTile, 'Swimming Suitable')).value, false);

    // Scroll to the Potable checkbox and toggle it
    await tester.ensureVisible(find.text('Potable'));
    await tester.tap(find.text('Potable'));
    await tester.pump();

    // Scroll to the Swimming Suitable checkbox and toggle it
    await tester.ensureVisible(find.text('Swimming Suitable'));
    await tester.tap(find.text('Swimming Suitable'));
    await tester.pump();

    // Verify the state after toggling
    expect(tester.widget<CheckboxListTile>(find.widgetWithText(CheckboxListTile, 'Potable')).value, true);
    expect(tester.widget<CheckboxListTile>(find.widgetWithText(CheckboxListTile, 'Swimming Suitable')).value, true);
  });
}
