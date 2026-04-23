import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final String? senderName;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isUser,
    this.senderName,
  });

  @override
  Widget build(BuildContext context) {
    if (isUser) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFF9500),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header IA
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFFFFDEA1),
                child: Icon(Icons.smart_toy, size: 18),
              ),
              const SizedBox(width: 8),
              Text(
                senderName ?? "Rulio",
                style: GoogleFonts.lilitaOne(
                  fontSize: 16,
                  color: const Color(0xFF5A3E1B),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Container(
            margin: const EdgeInsets.only(left: 40, bottom: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFFFDEA1)),
            ),
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: const Color(0xFF5A3E1B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}