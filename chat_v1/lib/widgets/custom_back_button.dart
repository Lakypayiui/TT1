import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final double borderWidth;
  final double size;

  const CustomBackButton({
    super.key,
    this.onPressed,
    this.backgroundColor = const Color(0xFFFFE5B7),
    this.borderColor = const Color(0xFFFFDEA1),
    this.iconColor = const Color(0xFFFF9500),
    this.borderWidth = 2,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: Icon(Icons.arrow_back, color: iconColor),
        onPressed: onPressed ?? () => Navigator.pop(context),
      ),
    );
  }
}