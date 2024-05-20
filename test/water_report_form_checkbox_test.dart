import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:project_es/screens/ReportCreation.dart';

void main() {
  testWidgets('WaterReportForm toggles potable and swimmingSuitable checkboxes', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: WaterReportForm()));

    // verifica se a tela de WaterReportForm está visível
    expect(find.byType(CheckboxListTile), findsNWidgets(2));
    expect(tester.widget<CheckboxListTile>(find.widgetWithText(CheckboxListTile, 'Potable')).value, false);
    expect(tester.widget<CheckboxListTile>(find.widgetWithText(CheckboxListTile, 'Swimming Suitable')).value, false);

    // da scroll para achar os checkboxes
    await tester.ensureVisible(find.text('Potable'));
    await tester.tap(find.text('Potable'));
    await tester.pump();

    await tester.ensureVisible(find.text('Swimming Suitable'));
    await tester.tap(find.text('Swimming Suitable'));
    await tester.pump();

    expect(tester.widget<CheckboxListTile>(find.widgetWithText(CheckboxListTile, 'Potable')).value, true);
    expect(tester.widget<CheckboxListTile>(find.widgetWithText(CheckboxListTile, 'Swimming Suitable')).value, true);
  });
}
