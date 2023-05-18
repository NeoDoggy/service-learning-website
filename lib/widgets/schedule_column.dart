import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleColumn extends StatelessWidget {
  const ScheduleColumn({
    super.key,
    required this.dateTime,
    required this.morning,
    required this.afternoon,
  });

  final DateTime dateTime;
  final String morning;
  final String afternoon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 30),
      decoration: BoxDecoration(
        color: const Color(0xFF0A2472),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Container(
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
                Text(
                  DateFormat("MM/dd").format(dateTime),
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat("E").format(dateTime),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 40),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  morning,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 40),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  afternoon,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
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
