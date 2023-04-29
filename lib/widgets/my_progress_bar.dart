// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import "package:flutter/material.dart";

class MyProgressBar extends StatelessWidget {
  final int all; // 所有課程數
  final int finished; // 已完成課程數

  const MyProgressBar({
    super.key,
    required this.all,
    required this.finished,
  });

  @override
  Widget build(BuildContext context) {
    String progress = '${(finished * 100 ~/ all).toInt()}%'; // 進度 e.g. 80%
    return Container(
      width: 391,
      height: 24,
      child: Row(
        children: [
          Text(
            '完成度',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              height: 24 / 20,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 20,
            height: 24,
          ),
          Container(
            width: 250,
            height: 15,
            child: Stack(
              children: [
                Container(
                  width: 250,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Color(0xffd9d9d9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Container(
                  width: 250 * finished / all,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Color(0xff1f6afb),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
            height: 24,
          ),
          Text(
            progress,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              height: 24.0 / 20.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
