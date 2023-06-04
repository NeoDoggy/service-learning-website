import 'package:flutter/material.dart';

class CourseExamResult extends StatelessWidget {
  const CourseExamResult({
    super.key,
    required this.isPassed,
  });

  final bool isPassed;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
          maxWidth: 600, maxHeight: 400),
      padding: const EdgeInsets.all(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            isPassed ? "通過測驗" : "未通過測驗",
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          Text(
            isPassed
                ? "恭喜你完成本章節測驗，繼續努力學習吧！"
                : "還有一些不太熟悉的地方呢！回頭看看影片和講義、多做練習，再來測驗一次吧！",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
