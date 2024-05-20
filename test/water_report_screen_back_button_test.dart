import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project_es/firebase_parse.dart';
import 'package:provider/provider.dart';
import 'package:project_es/screens/WaterReport.dart';

class MockFirebase extends Mock implements Firebase {}
class MockFirebaseApp extends Mock implements FirebaseApp {}
void main() {
  testWidgets('should navigate back when back button is tapped', (WidgetTester tester) async {
    // cria um mock de WaterResource para passar para a tela
    final waterResource = WaterResource(
      location: 'Test Location',
      coordinates: 'Test Coordinates',
      generalreport: 'SAFE',
      date: '2023-01-01',
      ph: 7.0,
      temperature: 22.0,
      oxygenLevels: '5',
      turbidity: 'Moderate',
      bacteriaLevels: 'Low',
      totalNitrogen: '0.4',
      totalPhosphorus: '0.2',
      conductivity: 'Moderate',
      potable: true,
      swimmingSuitable: true,
    );

    // dá inicialize ao WaterReportModel
    final waterReportModel = WaterReportModel();

    await tester.pumpWidget(
      ChangeNotifierProvider<WaterReportModel>.value(
        value: waterReportModel,
        child: MaterialApp(
          home: Scaffold(
            body: WaterReportScreen(resource: waterResource),
          ),
        ),
      ),
    );

    // checka se a tela de WaterReportScreen está visível e se aparece o texto 'Water Quality Report'
    expect(find.text('Water Quality Report'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_rounded));
    await tester.pumpAndSettle();

    // verifica novamente, dado que o back foi pressionado
    expect(find.text('Water Quality Report'), findsNothing);
  });
}
