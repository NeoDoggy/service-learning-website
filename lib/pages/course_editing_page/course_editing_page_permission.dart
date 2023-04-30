import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/course_data.dart';
import 'package:service_learning_website/modules/backend/user_data.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/providers/courses_provider.dart';
import 'package:service_learning_website/providers/users_provider.dart';
import 'package:service_learning_website/widgets/permission_denied.dart';

class CourseEditingPagePermission extends StatefulWidget {
  const CourseEditingPagePermission({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<CourseEditingPagePermission> createState() =>
      _CourseEditingPagePermissionState();
}

class _CourseEditingPagePermissionState
    extends State<CourseEditingPagePermission> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  List<String> _membersUid = [];
  bool _isEdited = false;
  String _keyword = "";

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final UserPermission permission =
            authProvider.userData?.permission ?? UserPermission.none;

        if (permission < UserPermission.ta) {
          return const PermissionDenied();
        }

        return Consumer2<CoursesProvider, UsersProvider>(
          builder: (context, coursesProvider, usersProvider, child) {
            final CourseData courseData =
                coursesProvider.coursesData[widget.id]!;
            _membersUid = courseData.members;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isEdited)
                  ElevatedButton(
                    onPressed: () {
                      coursesProvider.updateCourse(widget.id);
                      _isEdited = false;
                    },
                    child: const Text("儲存變更"),
                  ),
                if (_isEdited) const SizedBox(height: 40),
                const Text("組員",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 40),
                DataTable(columns: const [
                  DataColumn(label: Text("姓名")),
                  DataColumn(label: Text("學號")),
                  DataColumn(label: Text("Email")),
                  DataColumn(label: Text("移除")),
                ], rows: [
                  for (String uid in _membersUid)
                    DataRow(cells: [
                      DataCell(SelectableText(
                          usersProvider.usersData[uid]?.name ?? "")),
                      DataCell(SelectableText(
                          usersProvider.usersData[uid]?.studentId.toString() ??
                              "")),
                      DataCell(SelectableText(
                          usersProvider.usersData[uid]?.email ?? "")),
                      DataCell(
                        IconButton(
                            onPressed: () => setState(() {
                                  _membersUid.remove(uid);
                                  _isEdited = true;
                                }),
                            icon: const Icon(Icons.remove_circle,
                                color: Colors.red)),
                      )
                    ])
                ]),
                const Divider(height: 120),
                const Text("所有學生",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 40),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("搜尋"),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: TextField(
                          controller: _textController,
                          focusNode: _focusNode,
                          textInputAction: TextInputAction.done,
                          onTapOutside: (_) {
                            _focusNode.unfocus();
                            _filter(_textController.text);
                          },
                          onEditingComplete: () =>
                              _filter(_textController.text),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                DataTable(columns: const [
                  DataColumn(label: Text("姓名")),
                  DataColumn(label: Text("學號")),
                  DataColumn(label: Text("Email")),
                  DataColumn(label: Text("新增")),
                ], rows: [
                  for (UserData userData in usersProvider.usersData.values
                      .where((element) =>
                          element.permission >= UserPermission.student &&
                          !_membersUid.contains(element.uid) &&
                          (element.name.contains(_keyword) ||
                              element.email.contains(_keyword) ||
                              element.studentId.toString().contains(_keyword))))
                    DataRow(cells: [
                      DataCell(SelectableText(userData.name)),
                      DataCell(SelectableText(userData.studentId.toString())),
                      DataCell(SelectableText(userData.email)),
                      DataCell(
                        IconButton(
                            onPressed: () => setState(() {
                                  _membersUid.add(userData.uid);
                                  _isEdited = true;
                                }),
                            icon: const Icon(Icons.add_circle,
                                color: Colors.green)),
                      )
                    ])
                ]),
              ],
            );
          },
        );
      },
    );
  }

  void _filter(String keyword) {
    setState(() => _keyword = keyword);
  }
}
