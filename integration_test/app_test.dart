import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:project_es/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App loads and displays water report screen', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();  // espera a app carregar

    // checka se a tela principal está carregada e se tem o texto DigiWater
    expect(find.text('DigiWater'), findsOneWidget);

    // simula um clique no botão do water report
    await tester.tap(find.byIcon(Icons.star));
    await tester.pumpAndSettle();

    // verifica se a tela dos bookmarks tá visivel
    expect(find.text('Bookmarked Locations'), findsOneWidget);

    // simula um clique no botão de voltar
    await tester.tap(find.byIcon(Icons.arrow_back_rounded));
    await tester.pumpAndSettle();

    // ve se a tela principal está visível e se tem o texto DigiWater
    expect(find.text('DigiWater'), findsOneWidget);
  });
}
