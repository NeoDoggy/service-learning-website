import 'package:flutter/material.dart';

class ModifiableText extends StatefulWidget {
  const ModifiableText(
    this.text, {
    super.key,
    this.width,
    this.onEditingCompleted,
    this.restriction,
  });

  final String text;
  final double? width;

  final void Function(String value)? onEditingCompleted;

  /// 回傳 false 表示該值不被允許
  final bool Function(String value)? restriction;

  @override
  State<ModifiableText> createState() => _ModifiableTextState();
}

class _ModifiableTextState extends State<ModifiableText> {
  late final TextEditingController _controller;
  bool _isEditing = false;
  Widget? _showingWidget;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      _showingWidget = IntrinsicWidth(
        child: TextField(
          controller: _controller,
          autofocus: true,
          textInputAction: TextInputAction.done,
          onTapOutside: (_) => _handleEditingComplete(),
          onEditingComplete: () => _handleEditingComplete(),
        ),
      );
    } else {
      _showingWidget = InkWell(
        onTap: () => _toggleEditing(true),
        child: SelectionContainer.disabled(child: Text(_controller.text)),
      );
    }

    if (widget.width != null) {
      _showingWidget = SizedBox(width: widget.width, child: _showingWidget);
    }

    return _showingWidget ?? const Placeholder();
  }

  void _toggleEditing(bool state) {
    if (_isEditing != state) {
      setState(() => _isEditing = state);
    }
  }

  void _handleEditingComplete() {
    final String currentText = _controller.text;
    if (widget.restriction != null && !widget.restriction!(currentText)) {
      _controller.text = widget.text;
    } else if (widget.onEditingCompleted != null) {
      widget.onEditingCompleted!(currentText);
    }
    _toggleEditing(false);
  }
}
