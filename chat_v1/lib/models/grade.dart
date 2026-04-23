class Grade {
  final int? id;
  final int numero;

  Grade({
    this.id,
    required this.numero,
  });

  factory Grade.fromMap(Map<String, dynamic> map) {
    return Grade(
      id: map['id_grado'],
      numero: map['numero'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_grado': id,
      'numero': numero,
    };
  }
}