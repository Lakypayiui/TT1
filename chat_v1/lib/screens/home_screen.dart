import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/subject.dart';
import '../widgets/subject_card.dart';
// import '../widgets/custom_stroked_text.dart'; // si quieres usarlo en el título

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Datos de ejemplo (puedes venir de un provider, firebase, etc.)
  static final List<Subject> subjects = [
    Subject(
      name: "Matemáticas",
      progress: 0.85,
      icon: Icons.calculate_rounded,
      barColor: const Color(0xFFFF9500),
    ),
    Subject(
      name: "Español",
      progress: 0.62,
      icon: Icons.book_rounded,
      barColor: const Color(0xFFFFA726),
    ),
    Subject(
      name: "Ciencias",
      progress: 0.45,
      icon: Icons.science_rounded,
      barColor: const Color(0xFFFFB74D),
    ),
    Subject(
      name: "Historia",
      progress: 0.78,
      icon: Icons.history_edu_rounded,
      barColor: const Color(0xFFFF9800),
    ),
    Subject(
      name: "Geografía",
      progress: 0.33,
      icon: Icons.public_rounded,
      barColor: const Color(0xFFFFB300),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Tarjeta de perfil superior
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFA726), Color(0xFFFF6D00)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Avatar
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: const CircleAvatar(
                            backgroundColor: Color(0xFFBBDEFB),
                            radius: 36,
                            child: Text(
                              "👾",
                              style: TextStyle(fontSize: 48),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "JUAN PÉREZ",
                                style: GoogleFonts.lilitaOne(
                                  fontSize: 28,
                                  color: Colors.white,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "2° Grado",
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  color: Colors.white.withOpacity(0.95),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Botones AVATAR / VER PERFIL
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _smallButton("AVATAR"),
                        const SizedBox(width: 12),
                        _smallButton("VER PERFIL"),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Estadísticas
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _statItem("🔥", "7 DÍAS"),
                        const SizedBox(width: 32),
                        _statItem("\$", "1500"),
                      ],
                    ),
                  ],
                ),
              ),

              // Botón TIENDA
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: navegar a tienda
                  },
                  icon: const Icon(Icons.store_rounded, size: 28),
                  label: Text(
                    "TIENDA",
                    style: GoogleFonts.lilitaOne(fontSize: 22),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF42A5F5),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 6,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Sección Mis Materias
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "MIS MATERIAS",
                  style: GoogleFonts.lilitaOne(
                    fontSize: 28,
                    color: const Color(0xFFFF6D00),
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Lista de materias clickeables
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: subjects
                      .map((subject) => SubjectCard(
                            subject: subject,
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

  Widget _smallButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _statItem(String emoji, String value) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(width: 6),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}