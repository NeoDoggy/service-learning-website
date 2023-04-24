import 'package:flutter/material.dart';

class TitleTextBox extends StatelessWidget {

  const TitleTextBox(
    this.text, {
    super.key,
    this.width,
  });

  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: width,
          height: 100,
          padding: const EdgeInsets.only(
            left: 40, right: 40
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F4FF),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(text,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold))
          )
        ),
      ],
    );
  }
}