import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/activity/activity_participant_data.dart';
import 'package:service_learning_website/modules/backend/activity/grade.dart';
import 'package:service_learning_website/modules/backend/activity/meal_type.dart';
import 'package:service_learning_website/pages/activities_page/activity_enrolling_successful.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/providers/floating_window_provider.dart';

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
  final _mealRemarkTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  final _addiTextControllers = <TextEditingController>[];
  final _formKey = GlobalKey<FormState>();

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
    return Consumer2<AuthProvider, ActivitiesProvider>(
      builder: (context, authProvider, activitiesProvider, child) {
        final activityData =
            activitiesProvider.activitiesData[widget.activityId]!;
        if (activityData.participants[widget.uid] == null) {
          activityData.participants[widget.uid] =
              ActivityParticipantData(uid: widget.uid);
        }
        final participantData = activityData.participants[widget.uid]!;
        final questions = activityData.questions;
        for (int i = 0; i < questions.length; i++) {
          _addiTextControllers.add(TextEditingController());
        }

        return Container(
          constraints: BoxConstraints(
              maxWidth: 800,
              maxHeight: MediaQuery.of(context).size.height * 0.85),
          padding: const EdgeInsets.all(100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                      labelText: "姓名 *",
                      icon: Icon(Icons.person),
                    ),
                    validator: (value) =>
                        value!.trim().isEmpty ? "姓名不能為空" : null,
                  ),
                  TextFormField(
                    controller: _emailTextController,
                    decoration: const InputDecoration(
                      labelText: "Email *",
                      hintText: "報名成功後，將以此信箱寄發通知",
                      icon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Email 不能為空";
                      }
                      if (value.split("@").length != 2) {
                        return "Email 格式錯誤";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _schoolTextController,
                    decoration: const InputDecoration(
                      labelText: "學校 *",
                      icon: Icon(Icons.school),
                    ),
                    validator: (value) =>
                        value!.trim().isEmpty ? "學校不能為空" : null,
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
                      labelText: "年級 *",
                      icon: Icon(Icons.calendar_today),
                    ),
                    validator: (value) => value == null ? "年級不能為空" : null,
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
                      labelText: "午餐 *",
                      icon: Icon(Icons.lunch_dining),
                    ),
                    validator: (value) => value == null ? "午餐不能為空" : null,
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
                      labelText: "家長手機 *",
                      hintText: "用於緊急聯絡與營隊重要事項通知，僅需輸入數字",
                      icon: Icon(Icons.phone),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "家長手機不能為空";
                      }
                      if (value.trim().length != 10 ||
                          value.trim().contains(RegExp(r"[^0-9]"))) {
                        return "手機格式錯誤";
                      }
                      return null;
                    },
                  ),
                  for (int i = 0; i < questions.length; i++)
                    if (questions[i].choices.isEmpty)
                      TextFormField(
                        controller: _addiTextControllers[i],
                        decoration: InputDecoration(
                          labelText: "${questions[i].title} *",
                          icon: const Icon(Icons.question_answer),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "${questions[i].title}不能為空" : null,
                      )
                    else
                      DropdownButtonFormField(
                        onChanged: (value) =>
                            _addiTextControllers[i].text = value!,
                        items: questions[i]
                            .choices
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        decoration: InputDecoration(
                          labelText: "${questions[i].title} *",
                          icon: const Icon(Icons.question_mark),
                        ),
                        validator: (value) =>
                            value == null ? "${questions[i].title}不能為空" : null,
                      ),
                  const SizedBox(height: 50),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if ((_formKey.currentState as FormState).validate()) {
                          participantData.name = _nameTextController.text;
                          participantData.email = _emailTextController.text;
                          participantData.school = _schoolTextController.text;
                          participantData.grade = _gradeSelected!;
                          participantData.mealType = _mealSelected!;
                          participantData.maelRemark =
                              _mealRemarkTextController.text;
                          participantData.parentPhone =
                              _phoneTextController.text;
                          participantData.additional = {
                            for (int i = 0; i < questions.length; i++)
                              questions[i].title: _addiTextControllers[i].text
                          };

                          activitiesProvider.addParticipant(
                              widget.activityId, widget.uid);
                          authProvider.userData!.joinedActivities.add(widget.activityId);
                          authProvider.updateUser(widget.uid);
                          
                          context.read<FloatingWindowProvider>().child = null;
                          context.read<FloatingWindowProvider>().child =
                              const ActicvityEnrollingSuccessful();
                        }
                      },
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
