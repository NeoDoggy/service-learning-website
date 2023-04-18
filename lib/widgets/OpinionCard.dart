import 'dart:ui';

import 'package:flutter/material.dart';

class OpinonCard extends StatelessWidget {
  OpinonCard({
    super.key,
    required this.said,
  });

  String said;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        height: 100,
        width: 600,
        child: Row(
          children: [
            Icon(Icons.account_circle_outlined,color: Color(0xFF000000),size: 64,),
            SizedBox(width: 20,),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              color: Color(0xFFF0F8FF),
              elevation: 0,
              child: Container(
                width: 500,
                height: 96,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,top: 32),
                  child: Text(
                    said,
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 24
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
