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
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xFFFF9500);
    final borderColor = const Color(0xFFB87A00);
    final textColor = Colors.white;

    // 👇 desplazamiento vertical
    double offsetY = 0;
    if (_isPressed) {
      offsetY = 12; // baja cuando se presiona
    } else if (_isHover) {
      offsetY = -2; // sube cuando pasas el dedo
    }

    // 👇 borde inferior dinámico (simula profundidad)
    double bottomBorder = _isPressed ? 1 : 12;

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

      // 👇 detecta cuando el dedo entra/sale (drag)
      onPanStart: (_) => setState(() => _isHover = true),
      onPanEnd: (_) => setState(() => _isHover = false),

      onTap: widget.onPressed,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.translationValues(0, offsetY, 0), // 👈 movimiento
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: _isPressed ? bgColor.withOpacity(0.9) : bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border(
            top: BorderSide(color: borderColor, width: 6),
            left: BorderSide(color: borderColor, width: 6),
            right: BorderSide(color: borderColor, width: 6),
            bottom: BorderSide(color: borderColor, width: bottomBorder),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
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