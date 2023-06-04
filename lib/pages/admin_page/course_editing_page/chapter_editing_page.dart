import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/course/course_chapter_data.dart';
import 'package:service_learning_website/modules/backend/course/course_question_data.dart';
import 'package:service_learning_website/modules/backend/user/user_permission.dart';
import 'package:service_learning_website/modules/swapable.dart';
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
  List<TextEditingController> _questionsTextControllers = [];
  List<List<TextEditingController>> _choicesTextControllers = [];
  List<int> _correctChoices = [];

  bool _loaded = false;
  bool _canEdit = false;
  bool _isEdited = false;

  @override
  void dispose() {
    _titleTextController.dispose();
    _videoUrlTextController.dispose();
    _mdContentTextController.dispose();
    for (var controller in _questionsTextControllers) {
      controller.dispose();
    }
    for (var controllers in _choicesTextControllers) {
      for (var controller in controllers) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if ((authProvider.userData?.permission ?? UserPermission.none) <
        UserPermission.student) {
      return const Scaffold(body: Center(child: Text("Permission denied")));
    }

    final coursesProvider = Provider.of<CoursesProvider>(context);
    if (!_loaded) {
      _loaded = true;
      coursesProvider.loadCourse(widget.courseId);
    }
    if (coursesProvider
            .coursesData[widget.courseId]?.chapters[widget.chapterId] ==
        null) {
      return const Scaffold(body: Center(child: Text("Loading")));
    }

    return PageSkeleton(body: Consumer2<AuthProvider, CoursesProvider>(
      builder: (context, authProvider, coursesProvider, child) {
        final courseData = coursesProvider.coursesData[widget.courseId]!;
        final chapterData = courseData.chapters[widget.chapterId]!;
        final questions = chapterData.questions;
        _canEdit = (authProvider.userData?.permission ?? UserPermission.none) >=
                UserPermission.ta ||
            courseData.members.contains(authProvider.userData?.uid);

        if (!_isEdited) {
          _titleTextController.text = chapterData.title;
          _videoUrlTextController.text = chapterData.videoUrl;
          _mdContentTextController.text = chapterData.mdContent;
          _questionsTextControllers = questions
              .map((e) => TextEditingController(text: e.title))
              .toList();
          _choicesTextControllers = questions
              .map((e) => e.choices
                  .map((str) => TextEditingController(text: str))
                  .toList())
              .toList();
          _correctChoices = questions.map((e) => e.correct).toList();
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleTextBox("${chapterData.number + 1}. ${chapterData.title}"),
            const SizedBox(height: 60),
            if (_isEdited)
              ElevatedButton(
                  onPressed: () {
                    _save(chapterData, coursesProvider);
                  },
                  child:
                      const SelectionContainer.disabled(child: Text("儲存變更"))),
            if (_isEdited) const SizedBox(height: 40),
            const Text(
              "章節內容",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
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
            if (_isEdited) const SizedBox(height: 40),
            if (_isEdited)
              ElevatedButton(
                  onPressed: () => _save(chapterData, coursesProvider),
                  child:
                      const SelectionContainer.disabled(child: Text("儲存變更"))),
            const SizedBox(height: 60),
            const Text(
              "測驗題目",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _canEdit
                  ? () => setState(() {
                        _questionsTextControllers.add(TextEditingController());
                        _choicesTextControllers.add([]);
                        _correctChoices.add(-1);
                        _isEdited = true;
                      })
                  : null,
              icon: const Icon(Icons.add),
              label: const SelectionContainer.disabled(child: Text("新增問題")),
            ),
            const SizedBox(height: 40),
            for (int i = 0; i < _questionsTextControllers.length; i++)
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "題目 ${i + 1}",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                        OutlinedButton.icon(
                          onPressed: _canEdit
                              ? () => setState(() {
                                    _choicesTextControllers[i]
                                        .add(TextEditingController());
                                    _isEdited = true;
                                  })
                              : null,
                          icon: const Icon(Icons.add),
                          label: const SelectionContainer.disabled(
                              child: Text("新增選項")),
                        ),
                        const SizedBox(width: 20),
                        OutlinedButton.icon(
                          onPressed: i > 0 && _canEdit
                              ? () => setState(() {
                                    Swapable.swapList(
                                        _questionsTextControllers, i, i - 1);
                                    Swapable.swapList(
                                        _choicesTextControllers, i, i - 1);
                                    _isEdited = true;
                                  })
                              : null,
                          icon: const Icon(Icons.arrow_upward),
                          label: const SelectionContainer.disabled(
                              child: Text("上移")),
                        ),
                        const SizedBox(width: 20),
                        OutlinedButton.icon(
                          onPressed: i < _questionsTextControllers.length - 1 &&
                                  _canEdit
                              ? () => setState(() {
                                    Swapable.swapList(
                                        _questionsTextControllers, i, i + 1);
                                    Swapable.swapList(
                                        _choicesTextControllers, i, i + 1);
                                    _isEdited = true;
                                  })
                              : null,
                          icon: const Icon(Icons.arrow_downward),
                          label: const SelectionContainer.disabled(
                              child: Text("下移")),
                        ),
                        const SizedBox(width: 20),
                        OutlinedButton.icon(
                          onPressed: _canEdit
                              ? () => setState(() {
                                    for (var e in _choicesTextControllers[i]) {
                                      e.dispose();
                                    }
                                    _choicesTextControllers.removeAt(i);
                                    _questionsTextControllers[i].dispose();
                                    _questionsTextControllers.removeAt(i);
                                    _isEdited = true;
                                  })
                              : null,
                          icon: const Icon(Icons.delete),
                          label: const SelectionContainer.disabled(
                              child: Text("刪除題目")),
                        ),
                      ],
                    ),
                    TextField(
                      readOnly: !_canEdit,
                      controller: _questionsTextControllers[i],
                      onChanged: (_) => setState(() => _isEdited = true),
                      decoration: const InputDecoration(
                        label: Text("題目"),
                        icon: Icon(Icons.question_mark),
                      ),
                    ),
                    for (int j = 0; j < _choicesTextControllers[i].length; j++)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: TextField(
                              readOnly: !_canEdit,
                              controller: _choicesTextControllers[i][j],
                              onChanged: (_) =>
                                  setState(() => _isEdited = true),
                              decoration: InputDecoration(
                                  label: Text("選項 ${j + 1}"),
                                  icon: _correctChoices[i] == j
                                      ? const Icon(Icons.question_answer,
                                          color: Colors.green)
                                      : const Icon(
                                          Icons.question_answer_outlined,
                                          color: Colors.red)),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: _canEdit && _correctChoices[i] != j
                                ? () => setState(() {
                                      _isEdited = true;
                                      _correctChoices[i] = j;
                                    })
                                : null,
                            label: SelectionContainer.disabled(
                                child: Text(
                                    _correctChoices[i] != j ? "設為正解" : "正解")),
                            icon: const Icon(Icons.check),
                          ),
                          IconButton(
                            onPressed: _canEdit && j > 0
                                ? () => setState(() {
                                      Swapable.swapList(
                                          _choicesTextControllers[i], j, j - 1);
                                      _isEdited = true;
                                    })
                                : null,
                            icon: const Icon(Icons.arrow_upward),
                          ),
                          IconButton(
                            onPressed: _canEdit &&
                                    j < _choicesTextControllers[i].length - 1
                                ? () => setState(() {
                                      Swapable.swapList(
                                          _choicesTextControllers[i], j, j + 1);
                                      _isEdited = true;
                                    })
                                : null,
                            icon: const Icon(Icons.arrow_downward),
                          ),
                          IconButton(
                            onPressed: _canEdit
                                ? () => setState(() {
                                      _choicesTextControllers[i].removeAt(j);
                                      _isEdited = true;
                                    })
                                : null,
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    const Divider(height: 40),
                  ]),
            if (_isEdited) const SizedBox(height: 40),
            if (_isEdited)
              ElevatedButton(
                  onPressed: () => _save(chapterData, coursesProvider),
                  child:
                      const SelectionContainer.disabled(child: Text("儲存變更"))),
          ],
        );
      },
    ));
  }

  void _save(CourseChapterData chapterData, CoursesProvider coursesProvider) {
    chapterData.title = _titleTextController.text;
    chapterData.videoUrl = _videoUrlTextController.text;
    chapterData.mdContent = _mdContentTextController.text;
    chapterData.questions = [
      for (int i = 0; i < _questionsTextControllers.length; i++)
        CourseQuestionData(
          title: _questionsTextControllers[i].text,
          choices: _choicesTextControllers[i].map((e) => e.text).toList(),
          correct: _correctChoices[i],
        )
    ];
    coursesProvider.updateChapter(widget.courseId, widget.chapterId);
    setState(() => _isEdited = false);
  }
}
