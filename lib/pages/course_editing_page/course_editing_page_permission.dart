import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/providers/course_editing_page_provider.dart';
import 'package:service_learning_website/widgets/permission_denied.dart';

class CourseEditingPagePermission extends StatefulWidget {
  const CourseEditingPagePermission({super.key});

  @override
  State<CourseEditingPagePermission> createState() =>
      _CourseEditingPagePermissionState();
}

class _CourseEditingPagePermissionState
    extends State<CourseEditingPagePermission> {
  late TextEditingController _leaderController;
  late List<TextEditingController> _membersController;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final UserPermission permission =
            authProvider.userData?.permission ?? UserPermission.none;

        if (permission < UserPermission.ta) {
          const PermissionDenied();
        }

        return Consumer<CourseEditingPageProvider>(
          builder: (context, pageProvider, child) {
            _leaderController =
                TextEditingController(text: pageProvider.courseData.leader);
            _membersController = [];
            for (String member in pageProvider.courseData.members) {
              _membersController.add(TextEditingController(text: member));
            }

            return Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _leaderController,
                      decoration: const InputDecoration(
                        labelText: "組長",
                        hintText: "學號",
                        icon: Icon(Icons.person),
                      ),
                      onEditingComplete: () => _handleEditingComplete(),
                      onTapOutside: (_) => _handleEditingComplete(),
                    ),
                    for (int i = 0;
                        i < pageProvider.courseData.members.length;
                        i++)
                      Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: _membersController[i],
                              decoration: InputDecoration(
                                labelText: "組員 ${i + 1}",
                                hintText: "學號",
                                icon: const Icon(Icons.person_outline),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () => _deleteMember(),
                              icon: const Icon(Icons.remove_circle,
                                  color: Colors.red)),
                        ],
                      ),
                    IconButton(
                        // Add a member
                        onPressed: () => setState(
                            () => pageProvider.courseData.members.add("")),
                        icon: const Icon(Icons.add_circle, color: Colors.green))
                  ]),
            );
          },
        );
      },
    );
  }

  void _handleEditingComplete() {}
}
