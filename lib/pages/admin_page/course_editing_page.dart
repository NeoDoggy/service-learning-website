import 'package:flutter/material.dart';

class CourseEditingPage extends StatefulWidget {

  const CourseEditingPage(
    this.id, {
    super.key,
  });

  final String id;

  @override
  State<CourseEditingPage> createState() => _CourseEditingPageState();
}

class _CourseEditingPageState extends State<CourseEditingPage> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.id);
  }
}