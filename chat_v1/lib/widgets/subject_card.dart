import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/subject.dart';

class SubjectCard extends StatelessWidget {
  final Subject subject;
  final double progress; // 👈 nuevo parámetro
  final VoidCallback onTap;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).toInt();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFFFDEA1), width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icono
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                subject.icon,
                size: 32,
                color: const Color(0xFFFF9500),
              ),
            ),

            const SizedBox(width: 16),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.name.toUpperCase(),
                    style: GoogleFonts.lilitaOne(
                      fontSize: 20,
                      color: const Color(0xFF5A3E1B),
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress, // 👈 ahora externo
                            minHeight: 12,
                            backgroundColor: const Color(0xFFFFE8C3),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              subject.barColor,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Text(
                        "$percentage%",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF715822),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFFF9500),
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}