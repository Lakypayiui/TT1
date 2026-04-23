import 'package:chat_v1/models/student.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentHeader extends StatelessWidget {
  final Student student;

  const StudentHeader({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFF9500),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
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
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.black54,
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
                      student.name.toUpperCase(),
                      style: GoogleFonts.lilitaOne(
                        fontSize: 28,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${student.grade} Grado",
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

          // Botones
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
              _statItem(Icons.local_fire_department, "7 DÍAS"),
              const SizedBox(width: 32),
              _statItem(Icons.attach_money, "1500"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.lilitaOne(
          color: const Color(0xFFFF9500),
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _statItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.lilitaOne(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}