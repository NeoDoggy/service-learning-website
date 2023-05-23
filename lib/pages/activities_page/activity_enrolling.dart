import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/activity/activity_participant_data.dart';
import 'package:service_learning_website/modules/backend/activity/grade.dart';
import 'package:service_learning_website/modules/backend/activity/meal_type.dart';
import 'package:service_learning_website/providers/activities_provider.dart';

class ActivityEnrolling extends StatefulWidget {
  const ActivityEnrolling(
    this.activityId,
    this.uid, {
    super.key,
  });

  final String activityId;
  final String uid;

  @override
  State<ActivityEnrolling> createState() => _ActivityEnrollingState();
}

class _ActivityEnrollingState extends State<ActivityEnrolling> {
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _schoolTextController = TextEditingController();
  Grade? _gradeSelected;
  MealType? _mealSelected;
  // final _gradeTextController = TextEditingController();
  // final _mealTextController = TextEditingController();
  final _mealRemarkTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  final _addiTextControllers = <TextEditingController>[];

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _schoolTextController.dispose();
    _mealRemarkTextController.dispose();
    _phoneTextController.dispose();
    for (var controller in _addiTextControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivitiesProvider>(
      builder: (context, activitiesProvider, child) {
        final activityData =
            activitiesProvider.activitiesData[widget.activityId]!;
        if (activityData.participants[widget.uid] == null) {
          activityData.participants[widget.uid] =
              ActivityParticipantData(uid: widget.uid);
        }
        final participantData = activityData.participants[widget.uid]!;

        return Container(
          constraints: const BoxConstraints(maxWidth: 800),
          height: MediaQuery.of(context).size.height * 0.85,
          padding: const EdgeInsets.all(100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                      child: Text(
                    "報名資訊",
                    style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(height: 50),
                  TextFormField(
                    controller: _nameTextController,
                    decoration: const InputDecoration(
                      labelText: "姓名",
                      icon: Icon(Icons.person),
                    ),
                  ),
                  TextFormField(
                    controller: _emailTextController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "報名成功後，將以此信箱寄發通知",
                      icon: Icon(Icons.email),
                    ),
                  ),
                  TextFormField(
                    controller: _schoolTextController,
                    decoration: const InputDecoration(
                      labelText: "學校",
                      icon: Icon(Icons.school),
                    ),
                  ),
                  DropdownButtonFormField(
                    onChanged: (value) {
                      if (value != null) {
                        _gradeSelected = value;
                      }
                    },
                    items: Grade.values
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text(e.name)))
                        .toList(),
                    decoration: const InputDecoration(
                      labelText: "年級",
                      icon: Icon(Icons.calendar_today),
                    ),
                  ),
                  DropdownButtonFormField(
                    onChanged: (value) {
                      if (value != null) {
                        _mealSelected = value;
                      }
                    },
                    items: MealType.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.name),
                            ))
                        .toList(),
                    decoration: const InputDecoration(
                      labelText: "午餐",
                      icon: Icon(Icons.lunch_dining),
                    ),
                  ),
                  TextFormField(
                    controller: _mealRemarkTextController,
                    decoration: const InputDecoration(
                      labelText: "飲食需求",
                      hintText: "過敏原、宗教信仰",
                      icon: Icon(Icons.comment),
                    ),
                  ),
                  TextFormField(
                    controller: _phoneTextController,
                    decoration: const InputDecoration(
                      labelText: "家長電話",
                      hintText: "用於緊急聯絡與營隊重要事項通知",
                      icon: Icon(Icons.phone),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 24)),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                      ),
                      child: const SelectionContainer.disabled(
                          child: Text("確認報名")),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
