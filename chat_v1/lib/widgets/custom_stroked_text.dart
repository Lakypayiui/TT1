import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStrokedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color strokeColor;
  final double strokeWidth;
  final Color fillColor;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const CustomStrokedText({
    super.key,
    required this.text,
    this.fontSize = 70,
    this.strokeColor = const Color(0xFFFF9500),
    this.strokeWidth = 20,
    this.fillColor = Colors.white,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Contorno (stroke)
        Text(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: GoogleFonts.lilitaOne(
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        // Relleno (fill)
        Text(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: GoogleFonts.lilitaOne(
            fontSize: fontSize,
            color: fillColor,
          ),
        ),
      ],
    );
  }
}