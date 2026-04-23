class Subject {
  final int? id;
  final String name;
  final int gradeId;

  Subject({
    this.id,
    required this.name,
    required this.gradeId,
  });

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id_materia'],
      name: map['nombre'],
      gradeId: map['id_grado'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_materia': id,
      'nombre': name,
      'id_grado': gradeId,
    };
  }
}