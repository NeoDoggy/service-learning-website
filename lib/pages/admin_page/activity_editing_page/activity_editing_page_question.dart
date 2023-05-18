import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/activity/activity_question_data.dart';
import 'package:service_learning_website/modules/backend/user/user_permission.dart';
import 'package:service_learning_website/modules/swapable.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';

class ActivityEditingPageQuestion extends StatefulWidget {
  const ActivityEditingPageQuestion(
    this.activityId, {
    super.key,
  });

  final String activityId;

  @override
  State<ActivityEditingPageQuestion> createState() =>
      _ActivityEditingPageQuestionState();
}

class _ActivityEditingPageQuestionState
    extends State<ActivityEditingPageQuestion> {
  List<TextEditingController> _titleTextControllers = [];
  List<List<TextEditingController>> _choicesTextControllers = [];

  bool _canEdit = false;
  bool _isEdited = false;

  @override
  void dispose() {
    for (var controller in _titleTextControllers) {
      controller.dispose();
    }
    for (var controllers in _choicesTextControllers) {
      for (var controller in controllers) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ActivitiesProvider>(
      builder: (context, authProvider, activitiesProvider, child) {
        final courseData =
            activitiesProvider.activitiesData[widget.activityId]!;
        _canEdit = (authProvider.userData?.permission ?? UserPermission.none) >=
                UserPermission.ta ||
            courseData.members.contains(authProvider.userData?.uid);
        final questions = courseData.questions;

        if (!_isEdited) {
          _titleTextControllers = questions
              .map((e) => TextEditingController(text: e.title))
              .toList();
          _choicesTextControllers = questions
              .map((e) => e.choices
                  .map((str) => TextEditingController(text: str))
                  .toList())
              .toList();
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _canEdit
                      ? () => setState(() {
                            _titleTextControllers.add(TextEditingController());
                            _choicesTextControllers.add([]);
                            _isEdited = true;
                          })
                      : null,
                  icon: const Icon(Icons.add),
                  label: const Text("新增問題"),
                ),
                const SizedBox(width: 10),
                if (_isEdited)
                  ElevatedButton.icon(
                    onPressed: _canEdit
                        ? () {
                            _isEdited = false;
                            questions.clear();
                            for (int i = 0;
                                i < _titleTextControllers.length;
                                i++) {
                              questions.add(ActivityQuestionData(
                                title: _titleTextControllers[i].text,
                                choices: _choicesTextControllers[i]
                                    .map((e) => e.text)
                                    .toList(),
                              ));
                            }
                            activitiesProvider
                                .updateActivity(widget.activityId);
                          }
                        : null,
                    icon: const Icon(Icons.save),
                    label: const Text("儲存變更"),
                  ),
              ],
            ),
            const SizedBox(height: 40),
            const Text("當題目沒有選項時，該題為問答題"),
            const SizedBox(height: 20),
            for (int i = 0; i < _titleTextControllers.length; i++)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "題目 ${i + 1}",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 20),
                      OutlinedButton.icon(
                        onPressed: _canEdit
                            ? () => setState(() {
                                  _choicesTextControllers[i]
                                      .add(TextEditingController());
                                  _isEdited = true;
                                })
                            : null,
                        icon: const Icon(Icons.add),
                        label: const Text("新增選項"),
                      ),
                      const SizedBox(width: 20),
                      OutlinedButton.icon(
                        onPressed: i > 0 && _canEdit
                            ? () => setState(() {
                                  Swapable.swapList(
                                      _titleTextControllers, i, i - 1);
                                  Swapable.swapList(
                                      _choicesTextControllers, i, i - 1);
                                  _isEdited = true;
                                })
                            : null,
                        icon: const Icon(Icons.arrow_upward),
                        label: const Text("上移"),
                      ),
                      const SizedBox(width: 20),
                      OutlinedButton.icon(
                        onPressed:
                            i < _titleTextControllers.length - 1 && _canEdit
                                ? () => setState(() {
                                      Swapable.swapList(
                                          _titleTextControllers, i, i + 1);
                                      Swapable.swapList(
                                          _choicesTextControllers, i, i + 1);
                                      _isEdited = true;
                                    })
                                : null,
                        icon: const Icon(Icons.arrow_downward),
                        label: const Text("下移"),
                      ),
                      const SizedBox(width: 20),
                      OutlinedButton.icon(
                        onPressed: _canEdit
                            ? () => setState(() {
                                  for (var e in _choicesTextControllers[i]) {
                                    e.dispose();
                                  }
                                  _choicesTextControllers.removeAt(i);
                                  _titleTextControllers[i].dispose();
                                  _titleTextControllers.removeAt(i);
                                  _isEdited = true;
                                })
                            : null,
                        icon: const Icon(Icons.delete),
                        label: const Text("刪除題目"),
                      ),
                    ],
                  ),
                  TextField(
                    readOnly: !_canEdit,
                    controller: _titleTextControllers[i],
                    onChanged: (_) => setState(() => _isEdited = true),
                    decoration: const InputDecoration(
                      label: Text("題目"),
                      icon: Icon(Icons.question_mark),
                    ),
                  ),
                  for (int j = 0; j < _choicesTextControllers[i].length; j++)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: TextField(
                            readOnly: !_canEdit,
                            controller: _choicesTextControllers[i][j],
                            onChanged: (_) => setState(() => _isEdited = true),
                            decoration: InputDecoration(
                              label: Text("選項 ${j + 1}"),
                              icon: const Icon(Icons.question_answer),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: _canEdit && j > 0
                              ? () => setState(() {
                                    Swapable.swapList(
                                        _choicesTextControllers[i], j, j - 1);
                                    _isEdited = true;
                                  })
                              : null,
                          icon: const Icon(Icons.arrow_upward),
                        ),
                        IconButton(
                          onPressed: _canEdit &&
                                  j < _choicesTextControllers[i].length - 1
                              ? () => setState(() {
                                    Swapable.swapList(
                                        _choicesTextControllers[i], j, j + 1);
                                    _isEdited = true;
                                  })
                              : null,
                          icon: const Icon(Icons.arrow_downward),
                        ),
                        IconButton(
                          onPressed: _canEdit
                              ? () => setState(() {
                                    _choicesTextControllers[i].removeAt(j);
                                    _isEdited = true;
                                  })
                              : null,
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  const Divider(height: 40),
                ],
              )
          ],
        );
      },
    );
  }
}
