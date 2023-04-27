import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/providers/courses_provider.dart';

class CourseEditingPageInfo extends StatefulWidget {
  const CourseEditingPageInfo({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<CourseEditingPageInfo> createState() => _CourseEditingPageInfoState();
}

class _CourseEditingPageInfoState extends State<CourseEditingPageInfo> {
  final _titleTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _audienceTextController = TextEditingController();
  final _environmentTextController = TextEditingController();
  final _outlineTextController = TextEditingController();

  bool _isEdited = false;

  @override
  void dispose() {
    _titleTextController.dispose();
    _descriptionTextController.dispose();
    _audienceTextController.dispose();
    _environmentTextController.dispose();
    _outlineTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, CoursesProvider>(
      builder: (context, authProvider, coursesProvider, child) {
        final courseData = coursesProvider.coursesData[widget.id]!;
        final bool canEdit =
            (authProvider.userData?.permission ?? UserPermission.none) >=
                    UserPermission.ta ||
                courseData.members.contains(authProvider.userData?.uid);
        // final bool canEdit = false;

        if (!_isEdited) {
          _titleTextController.text = courseData.title;
          _descriptionTextController.text = courseData.description;
          _audienceTextController.text = courseData.audience;
          _environmentTextController.text = courseData.environment;
          _outlineTextController.text = courseData.outline;
        }

        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                enabled: canEdit,
                controller: _titleTextController,
                onChanged: (_) => setState(() => _isEdited = true),
                decoration: const InputDecoration(
                  labelText: "課程標題",
                  icon: Icon(Icons.text_fields),
                ),
              ),
              TextField(
                enabled: canEdit,
                controller: _descriptionTextController,
                onChanged: (_) => setState(() => _isEdited = true),
                decoration: const InputDecoration(
                  labelText: "課程介紹",
                  icon: Icon(Icons.description),
                ),
              ),
              TextField(
                enabled: canEdit,
                controller: _audienceTextController,
                onChanged: (_) => setState(() => _isEdited = true),
                decoration: const InputDecoration(
                  labelText: "適合對象",
                  icon: Icon(Icons.people),
                ),
              ),
              TextField(
                enabled: canEdit,
                controller: _environmentTextController,
                onChanged: (_) => setState(() => _isEdited = true),
                decoration: const InputDecoration(
                  labelText: "開發環境",
                  icon: Icon(Icons.computer),
                ),
              ),
              TextField(
                enabled: canEdit,
                controller: _outlineTextController,
                onChanged: (_) => setState(() => _isEdited = true),
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: "課程大綱",
                  hintText: "使用 Markdown 語法，可多換行輸入",
                  icon: Icon(Icons.list),
                ),
              ),
              TextField(
                enabled: canEdit,
                decoration: const InputDecoration(
                  labelText: "課程預覽圖",
                  icon: Icon(Icons.image),
                ),
              ),
              const SizedBox(height: 40),
              if (_isEdited)
                TextButton(
                    onPressed: () {
                      courseData.title = _titleTextController.text;
                      courseData.description = _descriptionTextController.text;
                      courseData.audience = _audienceTextController.text;
                      courseData.environment = _environmentTextController.text;
                      courseData.outline = _outlineTextController.text;
                      coursesProvider.updateCourse(widget.id);
                      setState(() => _isEdited = false);
                    },
                    child: const Text("儲存變更")),
            ]);
      },
    );
  }
}
