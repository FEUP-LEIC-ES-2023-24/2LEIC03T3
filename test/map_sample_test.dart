import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_es/consts.dart';
import 'package:project_es/mapSample.dart';

void main() {
  testWidgets('GoogleMap widget should be created',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: MapPage()));

    // Verify that the GoogleMap widget is created.
    expect(find.byType(GoogleMap), findsOneWidget);
  });

  test('_generateMarkers should generate correct number of markers', () {
    List<LatLng> coordinatesGeres = getList();

    final markers = _generateMarkers(coordinatesGeres);

    expect(markers.length, coordinatesGeres.length);
  });
}

Iterable<Marker> _generateMarkers(List<LatLng> coordinates) {
  return coordinates.map((coordinate) {
    return const Marker(
      markerId: MarkerId(coordinate.toString()),
      position: coordinate,
    );
  });
}
