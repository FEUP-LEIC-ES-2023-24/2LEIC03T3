import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../DatabaseHelper.dart';
import '../firebase_parse.dart';
import '../mapSample.dart';
import 'WaterReport.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<Map<String, dynamic>> _bookmarks = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    List<Map<String, dynamic>> rows = await DatabaseHelper.instance.queryAllRows();
    setState(() {
      _bookmarks = rows;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5BB5DA),
        leading: IconButton(
          padding: const EdgeInsets.only(left: 30),
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Bookmarks',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 30,
              letterSpacing: 0,
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: _bookmarks.isEmpty
          ? const Center(child: Text('No bookmarks'))
          : ListView.builder(
        itemCount: _bookmarks.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> bookmark = _bookmarks[index];
          return FutureBuilder<WaterResource>(
            future: getWaterResource(bookmark[DatabaseHelper.columnCoordinates]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                WaterResource resource = snapshot.data!;
                return ListTile(
                  title: Text(bookmark[DatabaseHelper.columnLocation]),
                  subtitle: Text(bookmark[DatabaseHelper.columnCoordinates]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (resource.swimmingSuitable)
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(FontAwesomeIcons.swimmer),
                        ),
                      if (getGeneralReportColor(resource) == Colors.red)
                        const Icon(
                          FontAwesomeIcons.exclamationTriangle,
                          color: Colors.red,
                        ),
                      if (getGeneralReportColor(resource) != Colors.red)
                        Icon(
                          FontAwesomeIcons.tint,
                          color: getGeneralReportColor(resource),
                          size: 20,
                        )
                    ],
                  ),
                  onTap: () async {
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
              }
            },
          );
        },
      ),
    );
  }
}

