import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_es/firebase_parse.dart';
import 'package:project_es/screens/WaterReport.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('should show WaterReportScreen when map pin is tapped', (WidgetTester tester) async {
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

    final waterReportModel = WaterReportModel();

    await tester.pumpWidget(
      ChangeNotifierProvider<WaterReportModel>.value(
        value: waterReportModel,
        child: MaterialApp(
          home: Scaffold(
            body: MapSample(
              onTapPin: (resource) {
                Navigator.push(
                  tester.element(find.byType(MapSample)),
                  MaterialPageRoute(
                    builder: (context) => WaterReportScreen(resource: resource),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(Key('mapPin')));
    await tester.pumpAndSettle();

    expect(find.text('Water Quality Report'), findsOneWidget);
    expect(find.text('Test Location'), findsOneWidget);
  });
}

class MapSample extends StatelessWidget {
  final Function(WaterResource) onTapPin;

  MapSample({required this.onTapPin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key('mapPin'),
      onTap: () {
        final resource = WaterResource(
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
        onTapPin(resource);
      },
      child: Container(
        color: Colors.blue,
        child: Center(
          child: Text('Map Sample'),
        ),
      ),
    );
  }
}
