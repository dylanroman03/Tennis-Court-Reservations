// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tennis/models/court.dart';
import 'package:tennis/models/reservation.dart';

class DatabaseProvider {
  DatabaseProvider._init();

  static final DatabaseProvider instance = DatabaseProvider._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tennis.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    createTables();
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  createTables() async {
    final db = await database;

    await db.execute(createTableCourt);
    await db.execute(createTableReservation);
  }

  dropTables() async {
    List<String> tables = [
      'court',
      'reservation',
    ];

    final db = await instance.database;

    for (var element in tables) {
      await db.execute('''
        DROP TABLE IF EXISTS `$element`;" 
      ''');
    }
  }

  Future<int> executeDelete(
    sql, {
    List items = const [],
  }) async {
    final db = await database;
    return await db.rawDelete(sql, items);
  }

  Future<List<Map<String, Object?>>> executeQuery(
    String query, {
    List items = const [],
  }) async {
    final db = await database;

    return await db.rawQuery(query, items);
  }

  Future<int> executeInsert(String query, List items) async {
    final db = await database;

    return await db.rawInsert(query, items);
  }

  Future<int> updateQuery(String query, {List items = const []}) async {
    final db = await database;
    return await db.rawUpdate(query, items);
  }

  Future<void> transaction(Future Function(Transaction txn) action) async {
    final db = await database;
    db.transaction(action);
  }
}
