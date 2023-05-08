// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class MCQ extends StatefulWidget {
  final String question;
  final List<String> options;

  MCQ({required this.question, required this.options});

  @override
  _MCQState createState() => _MCQState();
}

class _MCQState extends State<MCQ> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question,
          style: TextStyle(
            fontSize: 32,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 21),
        Column(
          children: List.generate(widget.options.length, (index) {
            return RadioListTile(
              title: Text(
                widget.options[index],
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              value: index,
              groupValue: selectedIndex,
              onChanged: (value) {
                setState(() {
                  selectedIndex = value!;
                });
              },
            );
          }),
        ),
      ],
    );
  }
}
