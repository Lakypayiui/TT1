import 'package:chat_v1/models/student.dart';
import 'package:chat_v1/widgets/primary_button.dart';
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
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFFF9500),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x55000000),
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.settings),
                color: const Color(0xFFFFFFFF),
                iconSize: 28,
                padding: EdgeInsets.zero,
                onPressed: () {
                  // acción
                },
              )
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 6),
              // Avatar
              Container(
                width: 135,
                height: 135,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  backgroundColor: Color(0xFFBBDEFB),
                  child: Icon(
                    Icons.person,
                    size: 120,
                    color: Colors.black54,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Text(
                          student.name.toUpperCase(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lilitaOne(
                            fontSize: 44,
                            color: Colors.white,
                            letterSpacing: 0.5,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${student.grade?.number ?? 'Grado no disponible'}° grado",
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            color: const Color(0xFF715822),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        PrimaryButton(
                          text: "AVATAR",
                          onPressed: () {},
                          fontSize: 12,
                          height: 40,
                          width: 100,
                          backgroundColor: const Color(0xFFB87A00),
                          borderColor: const Color(0xFF715822),
                          textColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                          borderWidth: 3,
                          borderBottomWidth: 6,
                        ),
                        const SizedBox(width: 8),
                        PrimaryButton(
                          text: "VER PERFIL",
                          onPressed: () {},
                          fontSize: 12,
                          height: 40,
                          width: 100,
                          backgroundColor: const Color(0xFFB87A00),
                          borderColor: const Color(0xFF715822),
                          textColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                          borderWidth: 3,
                          borderBottomWidth: 6,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),

          const SizedBox(height: 16),

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