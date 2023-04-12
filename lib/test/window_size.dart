import 'package:flutter/material.dart';

class WindowSize extends StatelessWidget {
  const WindowSize({super.key});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Text("Size: $width x $height");
  }
}