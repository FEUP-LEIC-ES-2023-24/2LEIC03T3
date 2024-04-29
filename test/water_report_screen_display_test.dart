import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_es/screens/WaterReport.dart';
import 'package:project_es/firebase_parse.dart';

void main() {
  testWidgets('WaterReportScreen displays correct data', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => WaterReportModel(),
        child: MaterialApp(
          home: WaterReportScreen(
            resource: WaterResource(
              location: 'Test Location',
              ph: 7.0,
              temperature: 25.0,
              bacteriaLevels: 'Low',
              turbidity: 'Low',
              oxygenLevels: '>6',
              totalNitrogen: '<0.5',
              totalPhosphorus: '<0.1',
              swimmingSuitable: true,
              potable: true,
              coordinates: '0,0',
              date: '2022-01-01 00:00:00',
              generalreport: 'Good',
              conductivity: 'Low',
            ),
          ),
        ),
      ),
    );

    expect(find.text('Test Location'), findsOneWidget);
    expect(find.text('2022-01-01 00:00:00'), findsOneWidget);
    expect(find.text('Good'), findsOneWidget);
    expect(find.text('25.0'), findsOneWidget);
    expect(find.text('Low'), findsWidgets);
    expect(find.text('>6'), findsOneWidget);
    expect(find.text('<0.5'), findsOneWidget);
    expect(find.text('<0.1'), findsOneWidget);
  });
}