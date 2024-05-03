import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_es/DatabaseHelper.dart';
import 'package:project_es/screens/WaterReport.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
//import 'package:project_es/screens/mapSample.dart';
import '../DatabaseHelper.dart';
import '../DatabaseHelper.dart';
import '../firebase_parse.dart';



import 'package:flutter/material.dart';
import 'package:project_es/DatabaseHelper.dart';
import 'package:project_es/screens/WaterReport.dart';
import 'package:project_es/firebase_parse.dart';
class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late List<Map<String, dynamic>> _bookmarks;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    _bookmarks = await DatabaseHelper.instance.queryAllRows();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5BB5DA),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 24,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        title: const Text(
            'Bookmarks',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 25,
                letterSpacing: 0,
                fontWeight: FontWeight.w600,
                color: Colors.white
            ),
          ),
        centerTitle: true,
        elevation: 0,
      ),
      body: _bookmarks.isEmpty
          ? Center(child: Text('No bookmarks'))
          : ListView.builder(
        itemCount: _bookmarks.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> bookmark = _bookmarks[index];
          return ListTile(
            title: Text(bookmark[DatabaseHelper.columnLocation]),
            subtitle: Text(bookmark[DatabaseHelper.columnCoordinates]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await DatabaseHelper.instance.delete(bookmark[DatabaseHelper.columnId]);
                _loadBookmarks();
              },
            ),
            onTap: () async {
              WaterResource resource = await getWaterResource(bookmark[DatabaseHelper.columnCoordinates]);
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WaterReportScreen(resource: resource),
                ),
              );
              if (result == 'update') {
                _loadBookmarks();
              }
            },
          );
        },
      ),
    );
  }
}
