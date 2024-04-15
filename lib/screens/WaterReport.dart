import 'package:flutter/material.dart';
import 'package:project_es/screens/Map.dart';

import '../mapSample.dart';

class DefaultWaterReportScreen extends StatelessWidget {
  const DefaultWaterReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapScreen()),
            );
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