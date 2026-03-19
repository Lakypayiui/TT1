import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOrangeButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  final double fontSize;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;

  const CustomOrangeButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize = 24,
    this.width,
    this.height,
    this.padding = const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  });

  @override
  State<CustomOrangeButton> createState() => _CustomOrangeButtonState();
}

class _CustomOrangeButtonState extends State<CustomOrangeButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xFFFF9500);
    final borderColor = const Color(0xFFB87A00);
    final textColor = Colors.white;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: _isPressed ? bgColor.withOpacity(0.85) : bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border(
            top: BorderSide(color: borderColor, width: 6),
            left: BorderSide(color: borderColor, width: 6),
            right: BorderSide(color: borderColor, width: 6),
            bottom: BorderSide(color: borderColor, width: 12),
          ),
        ),
        alignment: Alignment.center, // importante si defines height
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: GoogleFonts.lilitaOne(
            color: textColor,
            fontSize: widget.fontSize,
            letterSpacing: 2.5,
          ),
        ),
      ),
    );
  }
}