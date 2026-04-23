import 'package:chat_v1/models/grade.dart';
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

    // ---------------- GRADOS ----------------
    await db.execute('''
      CREATE TABLE grados (
        id_grado INTEGER PRIMARY KEY AUTOINCREMENT,
        numero INTEGER NOT NULL
      )
    ''');

    // ---------------- MATERIAS ----------------
    await db.execute('''
      CREATE TABLE materias (
        id_materia INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        id_grado INTEGER NOT NULL,
        FOREIGN KEY (id_grado) REFERENCES grados(id_grado)
          ON DELETE CASCADE
      )
    ''');

    // ---------------- TEMAS ----------------
    await db.execute('''
      CREATE TABLE temas (
        id_tema INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        id_materia INTEGER NOT NULL,
        FOREIGN KEY (id_materia) REFERENCES materias(id_materia)
          ON DELETE CASCADE
      )
    ''');

    // ---------------- ESTUDIANTES ----------------
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

    // ---------------- PROGRESO MATERIA ----------------
    await db.execute('''
      CREATE TABLE progreso_materia (
        id_progreso_materia INTEGER PRIMARY KEY AUTOINCREMENT,
        id_estudiante INTEGER NOT NULL,
        id_materia INTEGER NOT NULL,
        tema_actual INTEGER,
        porcentaje_completado REAL NOT NULL DEFAULT 0,
        ultimo_acceso TEXT,
        FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante)
          ON DELETE CASCADE,
        FOREIGN KEY (id_materia) REFERENCES materias(id_materia)
          ON DELETE CASCADE,
        FOREIGN KEY (tema_actual) REFERENCES temas(id_tema)
          ON DELETE SET NULL
      )
    ''');

    await seedInitialData(db);
  }

  Future<void> seedInitialData(Database db) async {
    // GRADOS
    await db.insert('grados', {'numero': 1});
    await db.insert('grados', {'numero': 2});
    await db.insert('grados', {'numero': 3});

    // Aquí después puedes agregar más seeds:
    // MATERIAS
    // TEMAS
    // ESTUDIANTES DEMO
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

  final result = await db.rawQuery('''
      SELECT 
        e.id_estudiante,
        e.nombre,
        e.correo,
        e.contrasena,
        e.id_grado,
        e.activo,
        e.bloqueado,
        e.monedas,
        g.id_grado AS g_id_grado,
        g.numero AS g_numero
      FROM estudiantes e
      LEFT JOIN grados g
        ON e.id_grado = g.id_grado
      WHERE e.id_estudiante = ?
    ''', [id]);

    if (result.isEmpty) return null;

    final row = result.first;

    return Student(
      id: row['id_estudiante'] as int,
      name: row['nombre'] as String,
      email: row['correo'] as String,
      password: row['contrasena'] as String,
      gradeId: row['id_grado'] as int,

      grade: (row['g_id_grado'] != null)
          ? Grade(
              id: row['g_id_grado'] as int,
              number: row['g_numero'] as int,
            )
          : null,

      active: row['activo'] == 1,
      blocked: row['bloqueado'] == 1,
      coins: row['monedas'] as int,
    );
  }

  Future<int> getGradeIdByNumber(int number) async {
    final db = await instance.database;

    final result = await db.query(
      'grados',
      where: 'numero = ?',
      whereArgs: [number],
      limit: 1,
    );

    if (result.isEmpty) {
      throw Exception('No existe un grado con numero = $number');
    }

    return result.first['id_grado'] as int;
  }

  Future<void> deleteAllTables() async {
    final db = await instance.database;

    await db.execute('DROP TABLE IF EXISTS estudiantes');
    await db.execute('DROP TABLE IF EXISTS progreso_materia');
    await db.execute('DROP TABLE IF EXISTS temas');
    await db.execute('DROP TABLE IF EXISTS materias');
    await db.execute('DROP TABLE IF EXISTS grados');

    // Volver a crear la DB
    await _createDB(db, 1);
  }
}