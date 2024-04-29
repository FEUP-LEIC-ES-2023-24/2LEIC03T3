import 'package:flutter_test/flutter_test.dart';
import 'package:project_es/firebase_parse.dart';

void main() {
  group('WaterResource', () {
    test('creates WaterResource from data', () {
      final data = {
        'location': 'Test Location',
        'ph': 7.0,
        'temperature': 25.0,
        'bacteria_levels': 'Low',
        'turbidity': 'Low',
        'oxygen_levels': '>6',
        'total_nitrogen': '<0.5',
        'total_phosphorus': '<0.1',
        'swimming_suitable': true,
        'potable': true,
        'coordinates': '0,0',
        'last_change': DateTime.now(),
        'general_report': 'Good',
        'conductivity': 'Low',
      };

      final resource = WaterResource(
        location: data['location'] as String,
        ph: data['ph'] as double,
        temperature: data['temperature'] as double,
        bacteriaLevels: data['bacteria_levels'] as String,
        turbidity: data['turbidity'] as String,
        oxygenLevels: data['oxygen_levels'] as String,
        totalNitrogen: data['total_nitrogen'] as String,
        totalPhosphorus: data['total_phosphorus'] as String,
        swimmingSuitable: data['swimming_suitable'] as bool,
        potable: data['potable'] as bool,
        coordinates: data['coordinates'] as String,
        date: data['last_change'].toString(),
        generalreport: data['general_report'] as String,
        conductivity: data['conductivity'] as String,
      );

      expect(resource.location, 'Test Location');
      expect(resource.ph, 7.0);
      expect(resource.temperature, 25.0);
      expect(resource.bacteriaLevels, 'Low');
      expect(resource.turbidity, 'Low');
      expect(resource.oxygenLevels, '>6');
      expect(resource.totalNitrogen, '<0.5');
      expect(resource.totalPhosphorus, '<0.1');
      expect(resource.swimmingSuitable, true);
      expect(resource.potable, true);
      expect(resource.coordinates, '0,0');
      expect(resource.generalreport, 'Good');
      expect(resource.conductivity, 'Low');
    });
  });
}