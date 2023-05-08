import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  final String txt;
  final Widget nextPage;

  const Bottom({super.key, required this.txt, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => nextPage,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
      ),
      child: Text(txt),
    );
  }
}
