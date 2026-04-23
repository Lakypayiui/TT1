import 'package:flutter/material.dart';

class Subject {
  final int? id;
  final String name;
  final int gradeId;

  // UI properties (no vienen de DB)
  final IconData icon;
  final Color barColor;

  Subject({
    this.id,
    required this.name,
    required this.gradeId,
    required this.icon,
    required this.barColor,
  });

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id_materia'],
      name: map['nombre'],
      gradeId: map['id_grado'],

      // valores por defecto si luego vienen de DB o mock
      icon: Icons.book_rounded,
      barColor: const Color(0xFFFF9500),
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