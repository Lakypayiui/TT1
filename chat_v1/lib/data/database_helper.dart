import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
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
      CREATE TABLE students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        grade TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertStudent({
    required String name,
    required String email,
    required String password,
    required String grade,
  }) async {
    final db = await instance.database;

    return await db.insert('students', {
      'name': name,
      'email': email,
      'password': password,
      'grade': grade,
    });
  }

  Future<Map<String, dynamic>?> getStudentByEmail(String email) async {
    final db = await instance.database;

    final result = await db.query(
      'students',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) return result.first;
    return null;
  }

  Future<void> deleteAllTables() async {
  final db = await instance.database;

  await db.execute('DROP TABLE IF EXISTS students');

  // Volver a crear la DB
  await _createDB(db, 1);
}
}