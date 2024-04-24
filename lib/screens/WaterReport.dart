import 'package:flutter/material.dart';
//import 'package:project_es/screens/mapSample.dart';
import '../firebase_parse.dart';
import '../mapSample.dart';

class DefaultWaterReportScreen extends StatelessWidget {
  const DefaultWaterReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(
              context);
          },
        ),
        title: const Text(
          'Water Quality Report',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF5bb5da),
      ),
      body: const Center(
        child: Text(
          'Water Report Screen',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}

class ReportScreen extends StatelessWidget {
  final WaterResource resource;

  ReportScreen({required this.resource});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resource.location),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('pH: ${resource.ph}'),
            Text('Temperature: ${resource.temperature}'),
            Text('Bacteria Levels: ${resource.bacteriaLevels}'),
            Text('Turbidity: ${resource.turbidity}'),
            Text('Oxygen Levels: ${resource.oxygenLevels}'),
            Text('Total Nitrogen: ${resource.totalNitrogen}'),
            Text('Total Phosphorus: ${resource.totalPhosphorus}'),
            Text('Swimming Suitable: ${resource.swimmingSuitable}'),
            Text('Potable: ${resource.potable}'),
            Text('Coordinates: ${resource.coordinates}'),
          ],
        ),
      ),
    );
  }
}