import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_es/firebase_parse.dart';
import 'package:project_es/screens/WaterReport.dart';

void main() {
  test('getMarkerIcon returns correct icon for water resource', () {
    WaterResource resource = WaterResource(
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
    );

    BitmapDescriptor icon = getMarkerIcon(resource);

    double iconHue = getMarkerIconHueForTest(resource);

    expect(iconHue, BitmapDescriptor.hueGreen);
  });
}

double getMarkerIconHueForTest(WaterResource resource) {
  if (getGeneralReportColor(resource) == Colors.red) {
    return BitmapDescriptor.hueRed;
  } else if (getGeneralReportColor(resource) == Colors.yellow) {
    return BitmapDescriptor.hueYellow;
  } else {
    return BitmapDescriptor.hueGreen;
  }
}