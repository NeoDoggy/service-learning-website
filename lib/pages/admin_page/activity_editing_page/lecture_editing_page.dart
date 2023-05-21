import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/activity/activity_lecture_data.dart';
import 'package:service_learning_website/modules/backend/user/user_permission.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';

class LectureEditingPage extends StatefulWidget {
  const LectureEditingPage(this.activiyId, this.lectureId, {super.key});

  final String activiyId;
  final String lectureId;

  @override
  State<LectureEditingPage> createState() => _LectureEditingPageState();
}

class _LectureEditingPageState extends State<LectureEditingPage> {
  final _titleTextController = TextEditingController();
  final _mdContentTextController = TextEditingController();

  bool _loaded = false;
  bool _canEdit = false;
  bool _isEdited = false;

  @override
  void dispose() {
    _titleTextController.dispose();
    _mdContentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if ((authProvider.userData?.permission ?? UserPermission.none) <
        UserPermission.student) {
      return const Scaffold(body: Center(child: Text("Permission denied")));
    }

    final activitiesProvider = Provider.of<ActivitiesProvider>(context);
    if (!_loaded) {
      _loaded = true;
      activitiesProvider.loadActivity(widget.activiyId);
    }
    if (activitiesProvider
            .activitiesData[widget.activiyId]?.lectures[widget.lectureId] ==
        null) {
      return const Scaffold(body: Center(child: Text("Loading")));
    }

    return PageSkeleton(body: Consumer2<AuthProvider, ActivitiesProvider>(
      builder: (context, authProvider, activitiesProvider, child) {
        final activityData = activitiesProvider.activitiesData[widget.activiyId]!;
        final lectureData = activityData.lectures[widget.lectureId]!;
        _canEdit = (authProvider.userData?.permission ?? UserPermission.none) >=
                UserPermission.ta ||
            activityData.members.contains(authProvider.userData?.uid);

        if (!_isEdited) {
          _titleTextController.text = lectureData.title;
          _mdContentTextController.text = lectureData.mdContent;
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleTextBox("${lectureData.number + 1}. ${lectureData.title}"),
            const SizedBox(height: 60),
            if (_isEdited)
              ElevatedButton(
                  onPressed: () {
                    _save(lectureData, activitiesProvider);
                  },
                  child: const SelectionContainer.disabled(child: Text("儲存變更"))),
            if (_isEdited) const SizedBox(height: 40),
            TextField(
              readOnly: !_canEdit,
              controller: _titleTextController,
              onChanged: (_) => setState(() => _isEdited = true),
              decoration: const InputDecoration(
                labelText: "章節標題",
                icon: Icon(Icons.text_fields),
              ),
            ),
            TextField(
              readOnly: !_canEdit,
              controller: _mdContentTextController,
              onChanged: (_) => setState(() => _isEdited = true),
              maxLines: null,
              decoration: const InputDecoration(
                labelText: "Markdown 講義內容",
                hintText: "使用 Markdown 語法，可多換行輸入",
                icon: Icon(Icons.description),
              ),
            ),
            if (_isEdited) const SizedBox(height: 40),
            if (_isEdited)
              ElevatedButton(
                  onPressed: () => _save(lectureData, activitiesProvider),
                  child: const SelectionContainer.disabled(child: Text("儲存變更"))),
          ],
        );
      },
    ));
  }

  void _save(ActivityLectureData lectureData, ActivitiesProvider coursesProvider) {
    lectureData.title = _titleTextController.text;
    lectureData.mdContent = _mdContentTextController.text;
    coursesProvider.updateLecture(widget.activiyId, widget.lectureId);
    setState(() => _isEdited = false);
  }
}
