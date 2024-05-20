import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_es/DatabaseHelper.dart';
import 'package:project_es/consts.dart';
import 'package:project_es/firebase_parse.dart';
import 'package:project_es/main.dart';
import 'package:project_es/mapSample.dart';
import 'package:mockito/mockito.dart';

//class MockDatabaseHelper extends Mock implements DatabaseHelper {}
void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });
  testWidgets('GoogleMap widget should be created with myLocationEnabled set to true',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: MapPage()));

    // Verify that the GoogleMap widget is created.
    expect(find.byType(GoogleMap), findsOneWidget);

    // Get the GoogleMap widget
    final googleMap = tester.widget<GoogleMap>(find.byType(GoogleMap));

    // Verify that myLocationEnabled is set to true
    expect(googleMap.myLocationEnabled, isTrue);
  });
  /*
  testWidgets('MapPage is rendered when FutureBuilder is done', (WidgetTester tester) async {
  // Mock the DatabaseHelper to return a Future that completes immediately
  final mockDatabaseHelper = MockDatabaseHelper();

  // Set up the behavior of the mockDatabaseHelper
  when(mockDatabaseHelper.getWaterResources()).thenAnswer((_) => Future.value([])); // Replace [] with your expected return value

  // Use the mockDatabaseHelper
  DatabaseHelper.instance = mockDatabaseHelper;

  // Build the MyApp widget
  await tester.pumpWidget(MyApp());

  // Let the Future complete
  await tester.pump();

  // Check that the MapPage widget is being rendered
  expect(find.byType(MapPage), findsOneWidget);
});
  */
  /*
  test('Test generateMarkers function', () {
  // Create a list of WaterResource objects
  List<WaterResource> resources = [
    WaterResource(location: 'Barragem de Vilarinho das Furnas', ph: 6.9, temperature: 17.5, bacteriaLevels: 'Low', turbidity: 'Low', oxygenLevels: '>6', totalNitrogen: '<0.5', totalPhosphorus: '<0.1', swimmingSuitable: true, potable: false, coordinates: '41.76368191432093, -8.208996898596055', date: '', generalreport: 'SAFE', conductivity: 'Low',),
    WaterResource(location: 'Location 2', ph: 6.9, temperature: 22, bacteriaLevels: 'High', turbidity: 'High', oxygenLevels: '>6', totalNitrogen: '<0.9', totalPhosphorus: '<1.1', swimmingSuitable: false, potable: false, coordinates: '41.76368191434521, -8.208996888596055', date: '', generalreport: 'SAFE', conductivity: 'Low',),
  ];

  MapPage mapPage = const MapPage();

  // Call the generateMarkers function
  Iterable<Marker> markers = mapPage.generateMarkers(resources);

  // Verify that the correct number of markers is returned
  expect(markers.length, equals(resources.length));

  // Verify that each marker has the correct position
  for (var marker in markers) {
    expect(resources.any((resource) {
      List<String> coordinates = resource.coordinates.split(', ');
      LatLng position = LatLng(double.parse(coordinates[0]), double.parse(coordinates[1]));
      return position == marker.position;
    }), isTrue);
  }
});
*/
}
