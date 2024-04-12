import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/home_page.dart'; // Import the HomePage widget
import 'widgets/water_report.dart'; // Import the WaterReportWidget
import 'models/water_report_model.dart'; // Import the WaterReportModel

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Quality App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => WaterReportModel()),
              ],
              child: HomePage(), // Set the HomePage as the initial route
            ),
        '/water_report': (context) => WaterReportWidget(), // Route for WaterReportWidget
      },
    );
  }
}
