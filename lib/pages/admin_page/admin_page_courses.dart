import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';
import 'package:service_learning_website/modules/my_router.dart';
import 'package:service_learning_website/providers/admin_page_courses_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';

class AdminPageCourses extends StatelessWidget {
  const AdminPageCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        
        UserPermission permission = authProvider.userData?.permission
          ?? UserPermission.none;

        if (permission < UserPermission.student) {
          return const Text("你沒有權限");
        }

        return Consumer<AdminPageCoursesProvider>(
          builder: (context, pageProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                if (permission >= UserPermission.ta)
                  TextButton(
                    onPressed: () => pageProvider.create(),
                    child: const Text("建立課程"),
                  ),
                if (permission >= UserPermission.ta)
                  const SizedBox(height: 40),

                DataTable(
                  columns: const [
                    DataColumn(label: Text("標題")),
                    DataColumn(label: Text("學期")),
                    DataColumn(label: Text("組長")),
                    DataColumn(label: Text("瀏覽／編輯")),
                  ],
                  rows: [
                    for (var courseData in pageProvider.coursesData)
                      DataRow(cells: [
                        DataCell(SelectableText(courseData.title)),
                        DataCell(SelectableText(courseData.semester)),
                        DataCell(SelectableText(courseData.leader)),
                        DataCell(
                          IconButton(
                            onPressed: () => context.push("${MyRouter.admin}/${MyRouter.course(courseData.id)}"),
                            icon: (permission >= UserPermission.ta
                                || courseData.leader == authProvider.userData!.uid
                                || courseData.members.contains(authProvider.userData!.uid))
                              ? const Icon(Icons.edit)
                              : const Icon(Icons.visibility),
                          )
                        ),
                      ]),
                  ],
                ),


              ],
            );
          },
        );
      },
    );
  }
}