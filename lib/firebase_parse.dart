import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
  final String generalreport;
  final String conductivity;

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
    required this.generalreport,
    required this.conductivity,
  });

  static WaterResource fromDocumentSnapshot(DocumentSnapshot doc) {
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
    date: DateFormat('yyyy-MM-dd HH:mm:ss').format(data['last_change'].toDate()),
    generalreport: data['general_report'],
    conductivity: data['conductivity'],
  );
}
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
      date: DateFormat('yyyy-MM-dd HH:mm:ss').format(data['last_change'].toDate()),
      generalreport: data['general_report'],
      conductivity: data['conductivity'],
    );
  }).toList();
}

Future<WaterResource> getWaterResource(String coordinates) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot querySnapshot = await firestore.collection('water_resources')
      .where('coordinates', isEqualTo: coordinates)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    Map<String, dynamic> data = querySnapshot.docs.first.data() as Map<String, dynamic>;
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
      date: DateFormat('yyyy-MM-dd HH:mm:ss').format(data['last_change'].toDate()),
      generalreport: data['general_report'],
      conductivity: data['conductivity'],
    );
  } else {
    throw Exception('Document does not exist on the database');
  }
}