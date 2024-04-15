import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:project_es/mapSample.dart';
import 'package:project_es/screens/WaterReport.dart';

void main() {
  testWidgets('taps back button and returns to previous screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Navigator(
        pages: [
          MaterialPage(child: MapPage()), // The previous screen
          MaterialPage(child: DefaultWaterReportScreen()), // The current screen
        ],
        onPopPage: (route, result) => route.didPop(result),
      ),
    ));

    // Find the back button and tap it.
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    // Verify that we've returned to the MapPage.
    expect(find.byType(MapPage), findsOneWidget);
    expect(find.byType(DefaultWaterReportScreen), findsNothing);
  });
}