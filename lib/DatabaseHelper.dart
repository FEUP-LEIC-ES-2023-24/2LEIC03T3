import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "BookmarksDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'bookmarks';

  static final columnId = '_id';
  static final columnLocation = 'location';
  static final columnCoordinates = 'coordinates';

  // torna esta classe singleton para garantir que apenas uma instancia da base de dados seja criada
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // tem apenas uma referência a database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnLocation TEXT NOT NULL,
            $columnCoordinates TEXT NOT NULL
          )
          ''');
  }

  // StreamController para emitir eventos quando os bookmarks são atualizados
  final _bookmarkStreamController = StreamController<List<Map<String, dynamic>>>.broadcast();

  Stream<List<Map<String, dynamic>>> get bookmarkStream => _bookmarkStreamController.stream;

  Future<void> _updateBookmarkStream() async {
    _bookmarkStreamController.add(await queryAllRows());
  }

  // métodos CRUD: create, read, update, delete LDTS lmao

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = await db.insert(table, row);
    _updateBookmarkStream();
    return id;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    int rowsAffected = await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
    _updateBookmarkStream();
    return rowsAffected;
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    int rowsAffected = await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
    _updateBookmarkStream();
    return rowsAffected;
  }
}

