import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_es/firebase_parse.dart';
import 'package:provider/provider.dart';
import 'package:project_es/screens/WaterReport.dart';


void main() {
  testWidgets('should navigate back when back button is tapped', (WidgetTester tester) async {
    // Criação de um WaterResource fictício para passar para a tela
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

    // Inicialize o modelo de WaterReportModel
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

    // Verifique se a tela de WaterReportScreen está visível
    expect(find.text('Water Quality Report'), findsOneWidget);

    // Toque no botão de voltar
    await tester.tap(find.byIcon(Icons.arrow_back_rounded));
    await tester.pumpAndSettle();

    // Verifique se a navegação de retorno foi feita
    // Como estamos testando sem um Navigator real, verificamos que o Navigator.pop foi chamado
    expect(find.text('Water Quality Report'), findsNothing);
  });
}
