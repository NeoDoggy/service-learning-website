import 'package:flutter/material.dart';

class EnhancedText extends StatefulWidget {

  const EnhancedText(
    this.text, {
    super.key,
    this.onTap,
    this.style = const TextStyle(),
  });

  final String text;
  final VoidCallback? onTap;
  final TextStyle style;

  @override
  State<EnhancedText> createState() => _EnhancedTextState();
}

class _EnhancedTextState extends State<EnhancedText> {

  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (event) => setState(() => _isHovered = true),
        onExit: (event) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: IgnorePointer(
          child: Text(
            widget.text,
            style: widget.style.copyWith(
              fontWeight: _isHovered ? FontWeight.bold : FontWeight.normal
            ),
          ),
        ),
      )
    );
  }
}