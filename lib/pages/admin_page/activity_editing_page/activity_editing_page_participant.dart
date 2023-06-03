import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/activity/activity_participant_data.dart';
import 'package:service_learning_website/modules/backend/activity/activity_question_data.dart';
import 'package:service_learning_website/modules/backend/user/user_permission.dart';
import 'package:service_learning_website/pages/admin_page/activity_editing_page/participant_detail.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/providers/floating_window_provider.dart';
import 'package:service_learning_website/widgets/permission_denied.dart';

class ActivityEditingPageParticipant extends StatefulWidget {
  const ActivityEditingPageParticipant(
    this.activityId, {
    super.key,
  });

  final String activityId;

  @override
  State<ActivityEditingPageParticipant> createState() =>
      _ActivityEditingPageParticipantState();
}

class _ActivityEditingPageParticipantState
    extends State<ActivityEditingPageParticipant> {
  bool _isEdited = false;

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ActivitiesProvider>(
        builder: (context, authProvider, activitiesProvider, child) {
      final userData = authProvider.userData!;
      final activityData =
          activitiesProvider.activitiesData[widget.activityId]!;
      if (userData.permission < UserPermission.ta &&
          !activityData.members.contains(userData.uid)) {
        return const PermissionDenied();
      }

      final participantsData = activityData.participants;
      final unprocessedParticipants =
          participantsData.values.where((e) => e.registrated == 0).toList();
      unprocessedParticipants
          .sort((a, b) => a.registrationTime.compareTo(b.registrationTime));
      final acceptedParticipants =
          participantsData.values.where((e) => e.registrated > 0).toList();
      acceptedParticipants
          .sort((a, b) => a.registrated.compareTo(b.registrated));
      final rejectedParticipants =
          participantsData.values.where((e) => e.registrated < 0).toList();
      rejectedParticipants
          .sort((a, b) => (-a.registrated).compareTo(-b.registrated));

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isEdited)
            ElevatedButton(
                onPressed: () {
                  activitiesProvider.updateParticipants(widget.activityId);
                  setState(() => _isEdited = false);
                },
                child: const SelectionContainer.disabled(child: Text("儲存變更"))),
          if (_isEdited) const SizedBox(height: 40),
          const Text("尚未處理",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          DataTable(
            columns: const [
              DataColumn(label: Text("姓名")),
              DataColumn(label: Text("報名時間")),
              DataColumn(label: Text("年級")),
              DataColumn(label: Text("Email")),
              DataColumn(label: Text("詳細資料")),
              DataColumn(label: Text("審核操作")),
            ],
            rows: [
              for (var participant in unprocessedParticipants)
                DataRow(cells: [
                  DataCell(Text(participant.name)),
                  DataCell(Text(DateFormat("yyyy/MM/dd HH:mm:ss")
                      .format(participant.registrationTime))),
                  DataCell(Text(participant.grade.name)),
                  DataCell(Text(participant.email)),
                  DataCell(_detailsButton(
                      context, activityData.questions, participant)),
                  DataCell(Row(children: [
                    IconButton(
                      onPressed: () => setState(() {
                        _isEdited = true;
                        participantsData[participant.uid]!.registrated =
                            acceptedParticipants.length + 1;
                      }),
                      icon: const Icon(Icons.check),
                    ),
                    IconButton(
                      onPressed: () => setState(() {
                        _isEdited = true;
                        participantsData[participant.uid]!.registrated =
                            -(rejectedParticipants.length + 1);
                      }),
                      icon: const Icon(Icons.close),
                    ),
                  ])),
                ]),
            ],
          ),
          const SizedBox(height: 40),
          const Text("正取名單",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          DataTable(
            columns: const [
              DataColumn(label: Text("序號")),
              DataColumn(label: Text("姓名")),
              DataColumn(label: Text("年級")),
              DataColumn(label: Text("午餐")),
              DataColumn(label: Text("飲食需求")),
              DataColumn(label: Text("Email")),
              DataColumn(label: Text("詳細資料")),
              DataColumn(label: Text("移至備取")),
            ],
            rows: [
              for (var participant in acceptedParticipants)
                DataRow(cells: [
                  DataCell(Text(participant.registrated.toString())),
                  DataCell(Text(participant.name)),
                  DataCell(Text(participant.grade.name)),
                  DataCell(Text(participant.mealType.name)),
                  DataCell(Text(participant.maelRemark)),
                  DataCell(Text(participant.email)),
                  DataCell(_detailsButton(
                      context, activityData.questions, participant)),
                  DataCell(IconButton(
                    onPressed: () => setState(() {
                      _isEdited = true;
                      for (var p in acceptedParticipants) {
                        if (p.registrated > participant.registrated) {
                          p.registrated--;
                        }
                      }
                      participantsData[participant.uid]!.registrated =
                          -(rejectedParticipants.length + 1);
                    }),
                    icon: const Icon(Icons.output),
                  )),
                ]),
            ],
          ),
          const SizedBox(height: 40),
          const Text("備取名單",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          DataTable(
            columns: const [
              DataColumn(label: Text("序號")),
              DataColumn(label: Text("姓名")),
              DataColumn(label: Text("報名時間")),
              DataColumn(label: Text("年級")),
              DataColumn(label: Text("Email")),
              DataColumn(label: Text("詳細資料")),
              DataColumn(label: Text("移至正取")),
            ],
            rows: [
              for (var participant in rejectedParticipants)
                DataRow(cells: [
                  DataCell(Text(participant.registrated.toString())),
                  DataCell(Text(participant.name)),
                  DataCell(Text(DateFormat("yyyy/MM/dd HH:mm:ss")
                      .format(participant.registrationTime))),
                  DataCell(Text(participant.grade.name)),
                  DataCell(Text(participant.email)),
                  DataCell(_detailsButton(
                      context, activityData.questions, participant)),
                  DataCell(IconButton(
                    onPressed: () => setState(() {
                      _isEdited = true;
                      for (var p in rejectedParticipants) {
                        if (p.registrated < participant.registrated) {
                          p.registrated++;
                        }
                      }
                      participantsData[participant.uid]!.registrated =
                          acceptedParticipants.length + 1;
                    }),
                    icon: const Icon(Icons.input),
                  )),
                ]),
            ],
          ),
          const SizedBox(height: 40),
        ],
      );
    });
  }

  IconButton _detailsButton(
      BuildContext context,
      List<ActivityQuestionData> questions,
      ActivityParticipantData participant) {
    return IconButton(
      onPressed: () {
        context.read<FloatingWindowProvider>().child =
            ParticipantDetail(questions, participant);
      },
      icon: const Icon(Icons.visibility),
    );
  }
}
