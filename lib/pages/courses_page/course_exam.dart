import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/course/course_question_data.dart';
import 'package:service_learning_website/pages/courses_page/course_exam_result.dart';
import 'package:service_learning_website/providers/floating_window_provider.dart';
import 'package:service_learning_website/widgets/mcq.dart';

class CourseExam extends StatelessWidget {
  const CourseExam({
    super.key,
    required this.questions,
    this.onFinished,
  });

  final List<CourseQuestionData> questions;
  final void Function(bool correct)? onFinished;

  @override
  Widget build(BuildContext context) {
    final List<int> selected = List.filled(questions.length, -1);

    return Container(
      constraints: BoxConstraints(
          maxWidth: 800, maxHeight: MediaQuery.of(context).size.height * 0.85),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
                child: Text(
              "章節測驗",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 50),
            for (int i = 0; i < questions.length; i++)
              MCQ(
                order: i + 1,
                title: questions[i].title,
                options: questions[i].choices,
                onSelectedChange: (value) => selected[i] = value,
              ),
            const SizedBox(height: 50),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  bool isAllCorrect = true;
                  for (int i = 0; i < questions.length; i++) {
                    if (selected[i] < 0 ||
                        selected[i] != questions[i].correct) {
                      isAllCorrect = false;
                    }
                  }
                  if (onFinished != null) {
                    onFinished!.call(isAllCorrect);
                  }
                  context.read<FloatingWindowProvider>().child =
                      CourseExamResult(isPassed: isAllCorrect);
                },
                style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll(Color(0xFF1F6AFB)),
                  foregroundColor: const MaterialStatePropertyAll(Colors.white),
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 20)),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                ),
                icon: const Icon(Icons.send_rounded),
                label: const SelectionContainer.disabled(child: Text("交卷")),
              ),
            )
          ],
        ),
      )),
    );
  }
}
