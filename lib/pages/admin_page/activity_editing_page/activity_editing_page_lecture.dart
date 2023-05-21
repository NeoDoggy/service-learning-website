import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user/user_permission.dart';
import 'package:service_learning_website/modules/my_router.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';

class ActivityEditingPageLecture extends StatefulWidget {
  const ActivityEditingPageLecture(
    this.lectureId, {
    super.key,
  });

  final String lectureId;

  @override
  State<ActivityEditingPageLecture> createState() =>
      _ActivityEditingPageLectureState();
}

class _ActivityEditingPageLectureState
    extends State<ActivityEditingPageLecture> {
  bool _canEdit = false;

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ActivitiesProvider>(
      builder: (context, authProvider, activitiesProvider, child) {
        final activityData = activitiesProvider.activitiesData[widget.lectureId]!;
        _canEdit = (authProvider.userData?.permission ?? UserPermission.none) >=
                UserPermission.ta ||
            activityData.members.contains(authProvider.userData?.uid);
        final lecturesList = activityData.lectures.values.toList();
        lecturesList.sort((a, b) => a.number.compareTo(b.number));

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_canEdit)
              ElevatedButton(
                onPressed: () => activitiesProvider.createLecture(widget.lectureId),
                child: const SelectionContainer.disabled(child: Text("新增講義")),
              ),
            if (_canEdit) const SizedBox(height: 40),
            DataTable(columns: [
              const DataColumn(label: Text("編號")),
              const DataColumn(label: Text("標題")),
              const DataColumn(label: Text("瀏覽／編輯")),
              if (_canEdit) const DataColumn(label: Text("移動順序")),
              if (_canEdit) const DataColumn(label: Text("刪除")),
            ], rows: [
              for (int i = 0; i < lecturesList.length; i++)
                DataRow(cells: [
                  DataCell(Text("${lecturesList[i].number + 1}")),
                  DataCell(Text(lecturesList[i].title)),
                  DataCell(IconButton(
                    onPressed: () => context.push(
                        "/${MyRouter.admin}/${MyRouter.activities}/${widget.lectureId}/${lecturesList[i].id}"),
                    icon: _canEdit
                        ? const Icon(Icons.edit)
                        : const Icon(Icons.visibility),
                  )),
                  if (_canEdit)
                    DataCell(Row(children: [
                      IconButton(
                          onPressed: i == 0
                              ? null
                              : () {
                                  setState(() {
                                    lecturesList[i].number--;
                                    lecturesList[i - 1].number++;
                                  });
                                  activitiesProvider.updateLecture(
                                      widget.lectureId, lecturesList[i].id);
                                  activitiesProvider.updateLecture(
                                      widget.lectureId, lecturesList[i - 1].id);
                                },
                          icon: const Icon(Icons.arrow_upward)),
                      IconButton(
                          onPressed: i == lecturesList.length - 1
                              ? null
                              : () {
                                  setState(() {
                                    lecturesList[i].number++;
                                    lecturesList[i + 1].number--;
                                  });
                                  activitiesProvider.updateLecture(
                                      widget.lectureId, lecturesList[i].id);
                                  activitiesProvider.updateLecture(
                                      widget.lectureId, lecturesList[i + 1].id);
                                },
                          icon: const Icon(Icons.arrow_downward)),
                    ])),
                  if (_canEdit)
                    DataCell(
                      IconButton(
                          onPressed: () {
                            setState(() {
                              for (int j = i + 1;
                                  j < lecturesList.length;
                                  j++) {
                                lecturesList[j].number--;
                              }
                            });
                            for (int j = i + 1; j < lecturesList.length; j++) {
                              activitiesProvider.updateLecture(
                                  widget.lectureId, lecturesList[j].id);
                            }
                            activitiesProvider.updateLecture(
                                widget.lectureId, lecturesList[i].id);
                            setState(() => lecturesList.removeAt(i));
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                ]),
            ])
          ],
        );
      },
    );
  }
}
