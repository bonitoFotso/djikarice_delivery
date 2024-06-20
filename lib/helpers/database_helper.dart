import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/order_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('orders.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        status TEXT,
        startLocation TEXT,
        distance REAL,
        description TEXT
      )
    ''');
  }

  Future<int> create(Order order) async {
    final db = await instance.database;
    return await db.insert('orders', order.toMap());
  }

  Future<List<Order>> readAllOrders() async {
    final db = await instance.database;
    final result = await db.query('orders');

    return result.map((json) => Order.fromMap(json)).toList();
  }

  Future<int> update(Order order) async {
    final db = await instance.database;

    return db.update(
      'orders',
      order.toMap(),
      where: 'id = ?',
      whereArgs: [order.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
