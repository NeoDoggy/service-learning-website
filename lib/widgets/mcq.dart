import 'package:flutter/material.dart';

class MCQ extends StatefulWidget {
  const MCQ({
    super.key,
    required this.order,
    required this.title,
    required this.options,
    this.onSelectedChange,
  });

  final int order;
  final String title;
  final List<String> options;
  final void Function(int value)? onSelectedChange;

  @override
  State<MCQ> createState() => _MCQState();
}

class _MCQState extends State<MCQ> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.order}. ${widget.title}",
          style: const TextStyle(
            fontSize: 24,
          ),
          textAlign: TextAlign.start,
        ),
        Column(
          children: List.generate(widget.options.length, (index) {
            return RadioListTile(
              title: Text(
                widget.options[index],
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              value: index,
              groupValue: selectedIndex,
              onChanged: (value) {
                setState(() {
                  selectedIndex = value!;
                });
                if (widget.onSelectedChange != null) {
                  widget.onSelectedChange!.call(selectedIndex);
                }
              },
            );
          }),
        ),
      ],
    );
  }
}
