import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/providers/courses_provider.dart';

class CourseEditingPageInfo extends StatefulWidget {
  const CourseEditingPageInfo(
    this.id, {
    super.key,
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
  bool _canEdit = false;
  bool _imageEdited = false;
  Uint8List? _imageByte;

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
        _canEdit = (authProvider.userData?.permission ?? UserPermission.none) >=
                UserPermission.ta ||
            courseData.members.contains(authProvider.userData?.uid);

        if (!_isEdited) {
          _titleTextController.text = courseData.title;
          _descriptionTextController.text = courseData.description;
          _audienceTextController.text = courseData.audience;
          _environmentTextController.text = courseData.environment;
          _outlineTextController.text = courseData.outline;
          if (_imageByte == null && courseData.imageUrl != "") {
            http
                .get(Uri.parse(courseData.imageUrl))
                .timeout(const Duration(seconds: 5))
                .then((response) =>
                    setState(() => _imageByte = response.bodyBytes))
                .catchError((_) => setState(() => _imageByte = null));
          }
        }

        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                readOnly: !_canEdit,
                controller: _titleTextController,
                onChanged: (_) => setState(() => _isEdited = true),
                decoration: const InputDecoration(
                  labelText: "課程標題",
                  icon: Icon(Icons.text_fields),
                ),
              ),
              TextField(
                readOnly: !_canEdit,
                controller: _descriptionTextController,
                onChanged: (_) => setState(() => _isEdited = true),
                decoration: const InputDecoration(
                  labelText: "課程介紹",
                  icon: Icon(Icons.description),
                ),
              ),
              TextField(
                readOnly: !_canEdit,
                controller: _audienceTextController,
                onChanged: (_) => setState(() => _isEdited = true),
                decoration: const InputDecoration(
                  labelText: "適合對象",
                  icon: Icon(Icons.people),
                ),
              ),
              TextField(
                readOnly: !_canEdit,
                controller: _environmentTextController,
                onChanged: (_) => setState(() => _isEdited = true),
                decoration: const InputDecoration(
                  labelText: "開發環境",
                  icon: Icon(Icons.computer),
                ),
              ),
              TextField(
                readOnly: !_canEdit,
                controller: _outlineTextController,
                onChanged: (_) => setState(() => _isEdited = true),
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: "課程大綱",
                  hintText: "使用 Markdown 語法，可多換行輸入",
                  icon: Icon(Icons.list),
                ),
              ),
              const SizedBox(height: 40),
              Row(children: [
                const Text("課程預覽圖片"),
                if (_canEdit) const SizedBox(width: 10),
                if (_canEdit)
                  ElevatedButton(
                      onPressed: () => _pickFile(), child: const Text("瀏覽檔案")),
              ]),
              const SizedBox(height: 20),
              if (_imageByte != null) Image.memory(_imageByte!),
              if (_imageByte == null) const Placeholder(),
              const SizedBox(height: 40),
              if (_isEdited)
                ElevatedButton(
                    onPressed: () {
                      courseData.title = _titleTextController.text;
                      courseData.description = _descriptionTextController.text;
                      courseData.audience = _audienceTextController.text;
                      courseData.environment = _environmentTextController.text;
                      courseData.outline = _outlineTextController.text;
                      coursesProvider.updateCourse(widget.id,
                          image: _imageEdited ? _imageByte : null);
                      setState(() => _isEdited = false);
                    },
                    child: const Text("儲存變更")),
            ]);
      },
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      setState(() {
        _imageByte = result.files.first.bytes;
        _isEdited = true;
        _imageEdited = true;
      });
    }
  }
}
