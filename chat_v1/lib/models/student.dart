import 'grade.dart';

class Student {
  final int? id;
  final String name;
  final String email;
  final String password;

  final int gradeId;
  final Grade? grade; // 👈 nuevo objeto

  final bool active;
  final bool blocked;
  final int coins;

  Student({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.gradeId,
    this.grade, // 👈 opcional
    this.active = true,
    this.blocked = false,
    this.coins = 0,
  });

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id_estudiante'],
      name: map['nombre'],
      email: map['correo'],
      password: map['contrasena'],
      gradeId: map['id_grado'],

      // si haces JOIN en el futuro puedes llenar esto
      grade: map['grado'] != null ? Grade.fromMap(map['grado']) : null,

      active: map['activo'] == 1,
      blocked: map['bloqueado'] == 1,
      coins: map['monedas'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_estudiante': id,
      'nombre': name,
      'correo': email,
      'contrasena': password,
      'id_grado': gradeId,
      'activo': active ? 1 : 0,
      'bloqueado': blocked ? 1 : 0,
      'monedas': coins,
    };
  }

  @override
  String toString() {
    return 'Student(id: $id, name: $name, gradeId: $gradeId, coins: $coins)';
  }
}