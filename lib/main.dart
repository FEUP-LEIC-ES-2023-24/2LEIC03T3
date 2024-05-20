import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mapSample.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/WaterReport.dart';
import 'screens/Bookmarks.dart';
import 'DatabaseHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<void> _loadBookmarksFuture;

  @override
  void initState() {
    super.initState();
    _loadBookmarksFuture = Future.delayed(const Duration(seconds: 4), () => DatabaseHelper.instance.queryAllRows());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _loadBookmarksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Image.asset('assets/DigiWaterlogo.png'),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return ChangeNotifierProvider(
            create: (context) => WaterReportModel(),
            child: MaterialApp(
              title: 'DigiWater',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: MapPage(),
            ),
          );
        }
      },
    );
  }
}