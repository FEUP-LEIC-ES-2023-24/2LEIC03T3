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
  List<Map<String, dynamic>> _selectedBookmarks = [];
  bool _isSelecting = false;

  // função para desativar o modo de seleção
  void _disableSelection() {
    setState(() {
      _isSelecting = false;
      _selectedBookmarks.clear(); // desmarca todos os bookmarks selecionados
    });
  }

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
        title: Text('Bookmarks'),
        leading: _isSelecting
            ? IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _disableSelection,
        )
            : null,
        actions: _isSelecting
            ? <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              for (var bookmark in _selectedBookmarks) {
                await DatabaseHelper.instance.delete(bookmark[DatabaseHelper.columnId]);
              }
              _loadBookmarks();
              _disableSelection();
            },
          ),
        ]
            : [],
      ),
      body: _bookmarks.isEmpty
          ? Center(child: Text('No bookmarks'))
          : ListView.builder(
        itemCount: _bookmarks.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> bookmark = _bookmarks[index];
          bool isSelected = _selectedBookmarks.contains(bookmark);
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
                  leading: isSelected ? Icon(Icons.circle, color: Colors.grey) : null, // adiciona um círculo cinza quando selecionado, falta aqui qualquer coisa no bool
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
                    if (_isSelecting) {
                      setState(() {
                        if (isSelected) {
                          _selectedBookmarks.remove(bookmark);
                        } else {
                          _selectedBookmarks.add(bookmark);
                        }
                      });
                    } else {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WaterReportScreen(resource: resource),
                        ),
                      );
                      if (result == 'update') {
                        _loadBookmarks();
                      }
                    }
                  },
                  onLongPress: () {
                    setState(() {
                      _isSelecting = true;
                      _selectedBookmarks.add(bookmark);
                    });
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