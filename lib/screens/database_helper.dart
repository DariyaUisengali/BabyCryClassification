import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute(
        'CREATE TABLE SpecialPages(id INTEGER PRIMARY KEY, pageName TEXT, dateTime TEXT)');
  }

  Future<int> insertSpecialPage(String pageName, String dateTime) async {
    final db = await database;
    return db.insert('SpecialPages', {'pageName': pageName, 'dateTime': dateTime});
  }

  Future<List<Map<String, dynamic>>> getSpecialPages() async {
    final db = await database;
    return db.query('SpecialPages');
  }
}

