import 'package:flutter/material.dart';

class BlankQuestion extends StatefulWidget {
  final String question;
  final String answer;
  const BlankQuestion({super.key, required this.question, required this.answer});

  @override
  State<BlankQuestion> createState() => _BlankQuestionState();
}

class _BlankQuestionState extends State<BlankQuestion> {
  TextEditingController answerController = TextEditingController();
  late String correctAnswer;
  late String question;
  String result = '';

  @override
  void initState() {
    super.initState();
    correctAnswer = widget.answer;
    question = widget.question;
  }

  void checkAnswer() {
    String userAnswer = answerController.text.trim();
    if (userAnswer.toLowerCase() == correctAnswer.toLowerCase()) {
      setState(() {
        result = 'Correct!';
      });
    } else {
      setState(() {
        result = 'Incorrect. Try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          question,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 200,
          child: TextField(
            controller: answerController,
            decoration: const InputDecoration(
              hintText: 'Enter your answer', // 提示文本
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: checkAnswer,
          child: const IgnorePointer(child: Text('Submit')),
        ),
        const SizedBox(height: 20),
        Text(
          result,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
