import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_es/mapSample.dart'; // Ensure correct import
import 'package:project_es/screens/WaterReport.dart'; // Ensure correct import
import 'package:cloud_firestore/cloud_firestore.dart'; // This is a Dart import

void main() {
  testWidgets('TapMapPin_ShowWaterReport', (WidgetTester tester) async {
    // Arrange: Use simple mock data or setup without `WaterResource`
    final mockLocation = 'Cascata Tahiti'; // Example location
    final mockCoordinates =
        '41.70374148864667, -8.109515773608667'; // Example coordinates

    // Build the widget without complex resource data
    await tester.pumpWidget(MaterialApp(
      home: MapPage(
          // Ensure `MapPage` accepts this structure without specific resource data
          ),
    ));

    // Act: Tap the map pin with the specific location
    await tester.tap(find.text(mockLocation)); // Tap by unique identifier
    await tester.pumpAndSettle(); // Ensure animations complete

    // Assert: Verify navigation to `WaterReportScreen`
    expect(find.byType(WaterReportScreen), findsOneWidget);

    // Additional assertions if needed, without using specific resource data
  });
}
