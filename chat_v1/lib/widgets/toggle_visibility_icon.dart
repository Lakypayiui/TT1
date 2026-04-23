import 'package:flutter/material.dart';

class ToggleVisibilityIcon extends StatefulWidget {
  final bool isObscured;
  final ValueChanged<bool> onChanged;
  final Color color;
  final double rightPadding;

  const ToggleVisibilityIcon({
    super.key,
    required this.isObscured,
    required this.onChanged,
    this.color = const Color(0xFFB87A00),
    this.rightPadding = 12,
  });

  @override
  State<ToggleVisibilityIcon> createState() => _ToggleVisibilityIconState();
}

class _ToggleVisibilityIconState extends State<ToggleVisibilityIcon>
    with SingleTickerProviderStateMixin {
  late bool _obscured;
  late AnimationController _controller;

  late Animation<double> _offsetAnim;
  late Animation<double> _scaleAnim;

  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _obscured = widget.isObscured;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );

    _offsetAnim = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -6.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -6.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_controller);

    _scaleAnim = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.15)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.15, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_controller);
  }

  void _toggle() async {
    setState(() {
      _obscured = !_obscured;
    });

    widget.onChanged(_obscured);

    await _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final darkerColor = widget.color.withOpacity(0.7);

    return Padding(
      padding: EdgeInsets.only(right: widget.rightPadding),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: _toggle,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _offsetAnim.value),
              child: Transform.scale(
                scale: _scaleAnim.value,
                child: child,
              ),
            );
          },
          child: Icon(
            _obscured ? Icons.visibility : Icons.visibility_off,
            color: _isPressed ? darkerColor : widget.color,
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant ToggleVisibilityIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isObscured != widget.isObscured) {
      _obscured = widget.isObscured;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}