import 'package:flutter/material.dart';
import 'package:service_learning_website/modules/backend/activity/activity_participant_data.dart';
import 'package:service_learning_website/modules/backend/activity/activity_question_data.dart';

class ParticipantDetail extends StatelessWidget {
  const ParticipantDetail(
    this.questionsData,
    this.participantData, {
    super.key,
  });

  final List<ActivityQuestionData> questionsData;
  final ActivityParticipantData participantData;

  @override
  Widget build(BuildContext context) {
    const contentStyle = TextStyle(fontSize: 16);

    return Container(
      constraints: BoxConstraints(
        maxWidth: 800,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: const EdgeInsets.all(100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: SelectionArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(participantData.name,
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(height: 50),
            Text("Email：${participantData.email}", style: contentStyle),
            Text("學校：${participantData.school}", style: contentStyle),
            Text("年級：${participantData.grade.name}", style: contentStyle),
            Text("午餐：${participantData.mealType.name}", style: contentStyle),
            Text("飲食需求：${participantData.maelRemark}", style: contentStyle),
            Text("家長電話：${participantData.parentPhone}", style: contentStyle),
            for (var question in participantData.additional.entries)
              if (questionsData.where((e) => e.id == question.key).isNotEmpty)
                Text(
                    "${questionsData.firstWhere((e) => e.id == question.key).title}：${question.value}",
                    style: contentStyle),
          ],
        ),
      ),
    );
  }
}
