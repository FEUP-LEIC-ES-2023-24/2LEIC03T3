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
  List<int> _selectedBookmarkIndexes = [];
  bool _isSelecting = false;

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

  void _toggleBookmarkSelection(int index) {
    setState(() {
      if (_selectedBookmarkIndexes.contains(index)) {
        _selectedBookmarkIndexes.remove(index);
        if (_selectedBookmarkIndexes.isEmpty) {
          _isSelecting = false;
        }
      } else {
        _selectedBookmarkIndexes.add(index);
        _isSelecting = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5BB5DA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Bookmarked Locations',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 25,
            letterSpacing: 0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: _isSelecting
            ? [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              for (var index in _selectedBookmarkIndexes) {
                await DatabaseHelper.instance.delete(_bookmarks[index][DatabaseHelper.columnId]);
              }
              _loadBookmarks();
              setState(() {
                _selectedBookmarkIndexes.clear();
                _isSelecting = false;
              });
            },
          ),
        ]
            : null,
      ),
      body: _bookmarks.isEmpty
          ? const Center(child: Text('No bookmarks', style: TextStyle(fontFamily: 'Poppins')))
          : ListView.builder(
        itemCount: _bookmarks.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> bookmark = _bookmarks[index];
          bool isSelected = _selectedBookmarkIndexes.contains(index);
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
                  leading: isSelected ? const Icon(Icons.check_circle, color: Colors.grey) : null,
                  title: Text(bookmark[DatabaseHelper.columnLocation], style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(bookmark[DatabaseHelper.columnCoordinates]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (resource.swimmingSuitable)
                        const Padding(
                          padding: EdgeInsets.only(right: 17),
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
                  onTap: () {
                    if (!_isSelecting) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WaterReportScreen(
                            resource: resource,
                          ),
                        ),
                      );
                    } else {
                      _toggleBookmarkSelection(index);
                    }
                  },
                  onLongPress: () {
                    _toggleBookmarkSelection(index);
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
