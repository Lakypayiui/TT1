class Grade {
  final int? id;
  final int number;

  Grade({
    this.id,
    required this.number,
  });

  factory Grade.fromMap(Map<String, dynamic> map) {
    return Grade(
      id: map['id_grado'],
      number: map['numero'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_grado': id,
      'numero': number,
    };
  }
}