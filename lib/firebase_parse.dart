import 'package:cloud_firestore/cloud_firestore.dart';

class WaterResource {
  final String location;
  final double ph;
  final double temperature;
  final String bacteriaLevels;
  final String turbidity;
  final String oxygenLevels;
  final String totalNitrogen;
  final String totalPhosphorus;
  final bool swimmingSuitable;
  final bool potable;
  final String coordinates;
  final String date;

  WaterResource({
    required this.location,
    required this.ph,
    required this.temperature,
    required this.bacteriaLevels,
    required this.turbidity,
    required this.oxygenLevels,
    required this.totalNitrogen,
    required this.totalPhosphorus,
    required this.swimmingSuitable,
    required this.potable,
    required this.coordinates,
    required this.date,

  });
}

Future<List<WaterResource>> getAllWaterResources() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot = await firestore.collection('water_resources').get();
  return querySnapshot.docs.map((doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return WaterResource(
      location: data['location'],
      ph: data['ph'],
      temperature: data['temperature'],
      bacteriaLevels: data['bacteria_levels'],
      turbidity: data['turbidity'],
      oxygenLevels: data['oxygen_levels'],
      totalNitrogen: data['total_nitrogen'],
      totalPhosphorus: data['total_phosphorus'],
      swimmingSuitable: data['swimming_suitable'],
      potable: data['potable'],
      coordinates: data['coordinates'],
      date: data['last_change'].toDate().toString(),
    );
  }).toList();
}