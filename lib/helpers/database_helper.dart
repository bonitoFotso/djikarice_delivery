import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'auth.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE auth (
        id INTEGER PRIMARY KEY,
        token TEXT
      )
    ''');
  }

  Future<void> saveToken(String token) async {
    final db = await database;
    await db.insert(
      'auth',
      {'token': token},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getToken() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('auth');
    if (maps.isNotEmpty) {
      return maps.first['token'];
    }
    return null;
  }

  Future<void> deleteToken() async {
    final db = await database;
    await db.delete('auth');
  }
}
