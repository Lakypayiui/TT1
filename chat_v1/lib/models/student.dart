class Student {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String grade;

  Student({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.grade,
  });

  // Convertir de Map (SQLite → objeto)
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      grade: map['grade'],
    );
  }

  // Convertir a Map (objeto → SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'grade': grade,
    };
  }

  // Para debug
  @override
  String toString() {
    return 'Student(id: $id, name: $name, email: $email, grade: $grade)';
  }
}