import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mapSample.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/WaterReport.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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