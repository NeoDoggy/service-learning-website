import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/providers/courses_provider.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';

class ChapterEditingPage extends StatefulWidget {
  const ChapterEditingPage(this.courseId, this.chapterId, {super.key});

  final String courseId;
  final String chapterId;

  @override
  State<ChapterEditingPage> createState() => _ChapterEditingPageState();
}

class _ChapterEditingPageState extends State<ChapterEditingPage> {
  final _titleTextController = TextEditingController();
  final _videoUrlTextController = TextEditingController();
  final _mdContentTextController = TextEditingController();

  bool _loaded = false;
  bool _canEdit = false;
  bool _isEdited = false;

  @override
  void dispose() {
    _titleTextController.dispose();
    _videoUrlTextController.dispose();
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

    final courseProvider = Provider.of<CoursesProvider>(context);
    if (!_loaded) {
      _loaded = true;
      courseProvider.loadCourse(widget.courseId);
    }
    if (courseProvider
            .coursesData[widget.courseId]?.chapters[widget.chapterId] ==
        null) {
      return const Scaffold(body: Center(child: Text("Loading")));
    }

    return PageSkeleton(body: Consumer2<AuthProvider, CoursesProvider>(
      builder: (context, authProvider, coursesProvider, child) {
        final courseData = coursesProvider.coursesData[widget.courseId]!;
        final chapterData = courseData.chapters[widget.chapterId]!;
        _canEdit = (authProvider.userData?.permission ?? UserPermission.none) >=
                UserPermission.ta ||
            courseData.members.contains(authProvider.userData?.uid);

        if (!_isEdited) {
          _titleTextController.text = chapterData.title;
          _videoUrlTextController.text = chapterData.videoUrl;
          _mdContentTextController.text = chapterData.mdContent;
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleTextBox(
                "${chapterData.number + 1}. ${chapterData.title}"),
            const SizedBox(height: 60),
            if (_isEdited)
              ElevatedButton(
                  onPressed: () {
                    chapterData.title = _titleTextController.text;
                    chapterData.videoUrl = _videoUrlTextController.text;
                    chapterData.mdContent = _mdContentTextController.text;
                    courseProvider.updateChapter(widget.courseId, widget.chapterId);
                    setState(() => _isEdited = false);
                  },
                  child: const Text("儲存變更")),
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
              controller: _videoUrlTextController,
              onChanged: (_) => setState(() => _isEdited = true),
              decoration: const InputDecoration(
                labelText: "YouTube 影片連結",
                icon: Icon(Icons.video_collection),
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
          ],
        );
      },
    ));
  }
}
