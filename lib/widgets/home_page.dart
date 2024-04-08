import 'package:flutter/material.dart';
import 'water_report.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WaterReportWidget()),
            );
          },
          child: Text('View Water Report'),
        ),
      ),
    );
  }
}
