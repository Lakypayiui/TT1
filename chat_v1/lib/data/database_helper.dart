import 'package:chat_v1/models/student.dart';
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
    await db.execute('PRAGMA foreign_keys = ON');

    await db.execute('''
      CREATE TABLE grados (
        id_grado INTEGER PRIMARY KEY AUTOINCREMENT,
        numero INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE materias (
        id_materia INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        id_grado INTEGER NOT NULL,
        FOREIGN KEY (id_grado) REFERENCES grados(id_grado)
          ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE estudiantes (
        id_estudiante INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        correo TEXT NOT NULL UNIQUE,
        contrasena TEXT NOT NULL,
        id_grado INTEGER NOT NULL,
        activo INTEGER NOT NULL DEFAULT 1,
        bloqueado INTEGER NOT NULL DEFAULT 0,
        monedas INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (id_grado) REFERENCES grados(id_grado)
          ON DELETE RESTRICT
      )
    ''');
  }

  Future<int> insertStudent(Student student) async {
    final db = await instance.database;
    return await db.insert('estudiantes', student.toMap());
  }

  Future<Student?> getStudentByEmail(String email) async {
    final db = await instance.database;

    final result = await db.query(
      'estudiantes',
      where: 'correo = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return Student.fromMap(result.first);
    }

    return null;
  }

  Future<Student?> getStudentById(int id) async {
    final db = await instance.database;

    final result = await db.query(
      'estudiantes',
      where: 'id_estudiante = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Student.fromMap(result.first);
    }

    return null;
  }

  Future<void> deleteAllTables() async {
    final db = await instance.database;

    await db.execute('DROP TABLE IF EXISTS estudiantes');
    await db.execute('DROP TABLE IF EXISTS materias');
    await db.execute('DROP TABLE IF EXISTS grados');

    // Volver a crear la DB
    await _createDB(db, 1);
  }
}