class Tema {
  final int? id;
  final String nombre;
  final int materiaId;

  Tema({
    this.id,
    required this.nombre,
    required this.materiaId,
  });

  factory Tema.fromMap(Map<String, dynamic> map) {
    return Tema(
      id: map['id_tema'],
      nombre: map['nombre'],
      materiaId: map['id_materia'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_tema': id,
      'nombre': nombre,
      'id_materia': materiaId,
    };
  }
}