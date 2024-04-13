import 'package:flutter/material.dart';
import 'package:project_es/screens/WaterReport.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DigiWater App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultWaterReportScreen(),
    );
  }
}