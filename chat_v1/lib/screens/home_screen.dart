import 'package:chat_v1/data/database_helper.dart';
import 'package:chat_v1/models/student.dart';
import 'package:chat_v1/services/session_service.dart';
import 'package:chat_v1/widgets/custom_stroked_text.dart';
import 'package:chat_v1/widgets/primary_button.dart';
import 'package:chat_v1/widgets/student_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/subject.dart';
import '../widgets/subject_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Student? student;

  @override
  void initState() {
    super.initState();
    _loadStudent();
  }

  Future<void> _loadStudent() async {
    final id = await SessionService.getSession();

    if (id == null) return;

    final s = await DatabaseHelper.instance.getStudentById(id);

    if (!mounted) return;

    setState(() {
      student = s;
    });
  }

  // Datos de ejemplo (puedes venir de un provider, firebase, etc.)
  static final List<Subject> subjects = [
    Subject(
      id: 1,
      name: "Matemáticas",
      gradeId: 1,
      icon: Icons.calculate_rounded,
      barColor: const Color(0xFFFF9500),
    ),
    Subject(
      id: 2,
      name: "Español",
      gradeId: 1,
      icon: Icons.book_rounded,
      barColor: const Color(0xFFFFA726),
    ),
    Subject(
      id: 3,
      name: "Ciencias",
      gradeId: 1,
      icon: Icons.science_rounded,
      barColor: const Color(0xFFFFB74D),
    ),
    Subject(
      id: 4,
      name: "Historia",
      gradeId: 1,
      icon: Icons.history_edu_rounded,
      barColor: const Color(0xFFFF9800),
    ),
    Subject(
      id: 5,
      name: "Geografía",
      gradeId: 1,
      icon: Icons.public_rounded,
      barColor: const Color(0xFFFFB300),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Tarjeta de perfil superior
              student == null
                ? const Center(child: CircularProgressIndicator())
                : StudentHeader(student: student!),

              SizedBox(height: height * 0.03),

              // Botón TIENDA
              PrimaryButton(
                  text: "TIENDA",
                  icon: Icons.store,
                  onPressed: () {},
                  fontSize: width * 0.08,
                  width: width * 0.9,
                  height: height * 0.11,
                  backgroundColor: const Color(0xFF00CCFE),
                  borderColor: const Color(0xFF098AA9),
              ),

              SizedBox(height: height * 0.03),

              Divider(
                color: Color(0xFFFFDEA1),
                thickness: 6,
                indent: width * 0.05,
                endIndent: width * 0.05,
              ),

              SizedBox(height: height * 0.04),

              // Sección Mis Materias
              Row(
                children: [
                  SizedBox(width: width * 0.05),
                  CustomStrokedText(
                    text: "MIS MATERIAS",
                    fontSize: width * 0.08,
                    strokeColor: const Color(0xFFFF9500),
                    strokeWidth: width * 0.025,
                    fillColor: Colors.white,
                  )
                ],
              ),

              SizedBox(height: height * 0.03),

              // Lista de materias clickeables
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: subjects
                      .map((subject) => SubjectCard(
                            subject: subject,
                            progress: 0.7, // 👈 valor de ejemplo, puede venir de un provider
                            onTap: () {
                              // Acción al tocar la materia
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Abriendo ${subject.name}")),
                              );
                              // Aquí iría Navigator.push a la pantalla de la materia
                            },
                          ))
                      .toList(),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

}