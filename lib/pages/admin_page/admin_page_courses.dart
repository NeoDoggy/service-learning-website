import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';
import 'package:service_learning_website/modules/my_router.dart';
import 'package:service_learning_website/providers/courses_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';

class AdminPageCourses extends StatefulWidget {
  const AdminPageCourses({super.key});

  @override
  State<AdminPageCourses> createState() => _AdminPageCoursesState();
}

class _AdminPageCoursesState extends State<AdminPageCourses> {

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        
        UserPermission permission = authProvider.userData?.permission
          ?? UserPermission.none;

        if (permission < UserPermission.student) {
          return const Text("你沒有權限");
        }

        return Consumer<CoursesProvider>(
          builder: (context, coursesProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                if (permission >= UserPermission.ta)
                  TextButton(
                    onPressed: () => coursesProvider.create(),
                    child: const Text("建立課程"),
                  ),
                if (permission >= UserPermission.ta)
                  const SizedBox(height: 40),

                Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      showBottomBorder: true,
                      columns: const [
                        DataColumn(label: Text("標題")),
                        DataColumn(label: Text("學期")),
                        DataColumn(label: Text("瀏覽／編輯")),
                      ],
                      rows: [
                        for (var courseData in coursesProvider.coursesData.values)
                          DataRow(cells: [
                            DataCell(SelectableText(courseData.title)),
                            DataCell(SelectableText(courseData.semester)),
                            DataCell(
                              IconButton(
                                onPressed: () => context.push("${MyRouter.admin}/${MyRouter.course(courseData.id)}"),
                                icon: (permission >= UserPermission.ta
                                    || courseData.members.contains(authProvider.userData!.uid))
                                  ? const Icon(Icons.edit)
                                  : const Icon(Icons.visibility),
                              )
                            ),
                          ]),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}