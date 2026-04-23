import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  final double fontSize;
  final double? width;
  final double? height;
  final double borderWidth;
  final double borderBottomWidth;
  final EdgeInsetsGeometry padding;

  final IconData? icon;
  final double iconSpacing;

  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize = 24,
    this.width,
    this.height,
    this.padding = const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
    this.backgroundColor = const Color(0xFFFF9500),
    this.borderColor = const Color(0xFFB87A00),
    this.textColor = Colors.white,
    this.icon,
    this.iconSpacing = 8,
    this.borderWidth = 6,
    this.borderBottomWidth = 12,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isPressed = false;
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    double offsetY = 0;
    if (_isPressed) {
      offsetY = widget.borderBottomWidth;
    } else if (_isHover) {
      offsetY = -2;
    }

    double bottomBorder = _isPressed ? 1 : widget.borderBottomWidth;

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

      onTap: () async {
        setState(() {
          _isPressed = true;
        });

        await Future.delayed(const Duration(milliseconds: 120));

        setState(() {
          _isPressed = false;
        });

        await Future.delayed(const Duration(milliseconds: 80));

        widget.onPressed();
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.translationValues(0, offsetY, 0),
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: _isPressed
              ? widget.backgroundColor.withOpacity(0.9)
              : widget.backgroundColor,
          borderRadius: BorderRadius.circular(25),
          border: Border(
            top: BorderSide(color: widget.borderColor, width: widget.borderWidth),
            left: BorderSide(color: widget.borderColor, width: widget.borderWidth),
            right: BorderSide(color: widget.borderColor, width: widget.borderWidth),
            bottom: BorderSide(color: widget.borderColor, width: bottomBorder),
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Icon(
                widget.icon,
                color: widget.textColor,
                size: widget.fontSize, // consistente con el texto
              ),
              SizedBox(width: widget.iconSpacing),
            ],
            Flexible(
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lilitaOne(
                  color: widget.textColor,
                  fontSize: widget.fontSize,
                  letterSpacing: 2.5,
                  height: 1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}