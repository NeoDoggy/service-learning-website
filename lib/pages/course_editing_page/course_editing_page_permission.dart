import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/course_data.dart';
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
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final UserPermission permission =
            authProvider.userData?.permission ?? UserPermission.none;

        if (permission < UserPermission.ta) {
          const PermissionDenied();
        }

        return Consumer2<CoursesProvider, UsersProvider>(
          builder: (context, coursesProvider, usersProvider, child) {
            final CourseData courseData =
                coursesProvider.coursesData[widget.id]!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("組員", style: TextStyle(fontSize: 24)),
                DataTable(columns: const [
                  DataColumn(label: Text("姓名")),
                  DataColumn(label: Text("學號")),
                  DataColumn(label: Text("移除")),
                ], rows: [
                  for (String membersUid in courseData.members)
                    DataRow(cells: [
                      DataCell(SelectableText(
                          usersProvider.usersData[membersUid]!.name)),
                      DataCell(SelectableText(usersProvider
                          .usersData[membersUid]!.studentId
                          .toString())),
                      DataCell(
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.remove_circle,
                                color: Colors.red)),
                      )
                    ])
                ])
              ],
            );

            // return Form(
            //   child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         TextFormField(
            //           controller: _leaderController,
            //           decoration: const InputDecoration(
            //             labelText: "組長",
            //             hintText: "學號",
            //             icon: Icon(Icons.person),
            //           ),
            //           onEditingComplete: () => _handleEditingComplete(),
            //           onTapOutside: (_) => _handleEditingComplete(),
            //         ),
            //         for (int i = 0;
            //             i < pageProvider.courseData.members.length;
            //             i++)
            //           Row(
            //             children: [
            //               Flexible(
            //                 child: TextFormField(
            //                   controller: _membersController[i],
            //                   decoration: InputDecoration(
            //                     labelText: "組員 ${i + 1}",
            //                     hintText: "學號",
            //                     icon: const Icon(Icons.person_outline),
            //                   ),
            //                 ),
            //               ),
            //               IconButton(
            //                   onPressed: () => _deleteMember(),
            //                   icon: const Icon(Icons.remove_circle,
            //                       color: Colors.red)),
            //             ],
            //           ),
            //         IconButton(
            //             // Add a member
            //             onPressed: () => setState(
            //                 () => pageProvider.courseData.members.add("")),
            //             icon: const Icon(Icons.add_circle, color: Colors.green))
            //       ]),
            // );
          },
        );
      },
    );
  }
}
