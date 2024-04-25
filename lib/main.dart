import 'package:flutter/material.dart';
import 'mapSample.dart';
import 'package:provider/provider.dart';
import 'screens/WaterReport.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WaterReportModel(),
      child: MaterialApp(
        title: 'DigiWater App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MapPage(),
      ),
    );
  }
}