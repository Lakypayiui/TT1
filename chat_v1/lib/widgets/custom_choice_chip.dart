import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomChoiceChip extends StatefulWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomChoiceChip({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<CustomChoiceChip> createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<CustomChoiceChip> {
  bool _isPressed = false;
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.isSelected
        ? const Color(0xFFB87A00)
        : const Color(0xFFFFDEA1);

    // 👇 movimiento vertical
    double offsetY = 0;
    if (_isPressed) {
      offsetY = 5;
    } else if (_isHover) {
      offsetY = -2;
    }

    // 👇 profundidad
    double bottomBorder = _isPressed ? 2 : 8;

    return GestureDetector(
      onTapDown: (_) => setState(() {
        _isPressed = true;
        _isHover = false;
      }),
      onTapUp: (_) => setState(() {
        _isPressed = false;
      }),
      onTapCancel: () => setState(() {
        _isPressed = false;
        _isHover = false;
      }),
      onPanStart: (_) => setState(() => _isHover = true),
      onPanEnd: (_) => setState(() => _isHover = false),
      onTap: widget.onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        transform: Matrix4.translationValues(0, offsetY, 0),
        padding: const EdgeInsets.symmetric(vertical: 14),

        decoration: BoxDecoration(
          color: widget.isSelected
              ? const Color(0xFFFF9500)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border(
            top: BorderSide(color: borderColor, width: 6),
            left: BorderSide(color: borderColor, width: 6),
            right: BorderSide(color: borderColor, width: 6),
            bottom: BorderSide(color: borderColor, width: bottomBorder),
          ),
        ),

        child: Center(
          child: Text(
            widget.text,
            style: GoogleFonts.lilitaOne(
              color: widget.isSelected
                  ? Colors.white
                  : Colors.black87,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}