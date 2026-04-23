class ProgresoMateria {
  final int? id;
  final int studentId;
  final int subjectId;
  final int? currentTopicId;
  final double progress;
  final String? lastAccess;

  ProgresoMateria({
    this.id,
    required this.studentId,
    required this.subjectId,
    this.currentTopicId,
    this.progress = 0,
    this.lastAccess,
  });

  factory ProgresoMateria.fromMap(Map<String, dynamic> map) {
    return ProgresoMateria(
      id: map['id_progreso_materia'],
      studentId: map['id_estudiante'],
      subjectId: map['id_materia'],
      currentTopicId: map['tema_actual'],
      progress: map['porcentaje_completado'],
      lastAccess: map['ultimo_acceso'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_progreso_materia': id,
      'id_estudiante': studentId,
      'id_materia': subjectId,
      'tema_actual': currentTopicId,
      'porcentaje_completado': progress,
      'ultimo_acceso': lastAccess,
    };
  }
}