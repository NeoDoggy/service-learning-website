import 'package:flutter/material.dart';

class ScheduleColumn extends StatelessWidget {
  const ScheduleColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1240.0,
      height: 200.0,
      decoration: BoxDecoration(
        color: const Color(0xFF0A2472),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 40.0,
            top: 40.0,
            child: Container(
              width: 120.0,
              height: 120.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    // ignore: prefer_const_literals_to_create_immutables
                    [
                  const Text(
                    '日期',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '\n星期',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 230.0,
            top: 30.0,
            child: Container(
              width: 450.0,
              height: 140.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text(
                  '文字文字文字文字',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 720.0,
            top: 30.0,
            child: Container(
              width: 480.0,
              height: 140.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text(
                  '文字文字文字文字',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
