import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/course/course_chapter_data.dart';
import 'package:service_learning_website/modules/my_router.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/providers/courses_provider.dart';
import 'package:service_learning_website/widgets/my_markdown.dart';
import 'package:service_learning_website/widgets/my_progress_bar.dart';
import 'package:service_learning_website/widgets/side_menu.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';
import 'package:service_learning_website/widgets/youtube_player.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({
    super.key,
    required this.courseId,
    this.chapterId,
  });

  final String courseId;
  final String? chapterId;

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  bool _loaded = false;
  bool _loading = true;
  bool _isParticipant = false;

  @override
  Widget build(BuildContext context) {
    return PageSkeleton(
      body: Consumer2<AuthProvider, CoursesProvider>(
        builder: (context, authProvider, coursesProvider, child) {
          // 確保課程加載完成
          if (!_loaded) {
            _loaded = true;
            coursesProvider
                .loadCourse(widget.courseId)
                .then((_) => setState(() => _loading = false));
          }
          if (_loading ||
              coursesProvider.coursesData[widget.courseId] == null) {
            return const Center(child: Text("Loading"));
          }

          final userData = authProvider.userData;
          final courseData = coursesProvider.coursesData[widget.courseId]!;

          // 尚未加入課程者，引入課程說明頁面
          _isParticipant = courseData.participants[userData?.uid ?? ""] != null;

          if (!_isParticipant) {
            WidgetsBinding.instance.addPostFrameCallback((_) => context.go(
                "/${MyRouter.courses}/${widget.courseId}/${MyRouter.intro}"));
            return const Center(child: Text("Loading"));
          }

          final participantData = courseData.participants[userData!.uid]!;

          // 依照 chapterId 顯示不同的內容
          final chaptersList = courseData.chapters.values.toList();
          if (chaptersList.isEmpty) {
            return const Center(child: Text("課程沒有任何內容"));
          }
          chaptersList.sort((a, b) => a.number.compareTo(b.number));
          if (widget.chapterId == null) {
            for (int i = 0; i < chaptersList.length; i++) {
              if (!participantData.completed.contains(chaptersList[i].id) ||
                  i == chaptersList.length - 1) {
                WidgetsBinding.instance.addPostFrameCallback((_) => context.go(
                    "/${MyRouter.courses}/${widget.courseId}?chapter=${chaptersList[i].id}"));
                break;
              }
            }
          }
          final chapterData = courseData.chapters[widget.chapterId];

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleTextBox(courseData.title),
              const SizedBox(height: 40),
              MyProgressBar(
                all: courseData.chapters.length,
                finished: participantData.completed.length,
              ),
              const SizedBox(height: 60),
              LayoutBuilder(builder: (context, constraint) {
                final double ytWidth = constraint.maxWidth / 25 * 18;
                return SizedBox(
                  height: YoutubePlayer.getHeightFromWidth(ytWidth),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 18,
                        child: YoutubePlayer(
                          width: ytWidth,
                          url: chapterData?.videoUrl ?? "",
                        ),
                      ),
                      Flexible(flex: 1, child: Container()),
                      Flexible(
                        flex: 6,
                        child: SideMenu(
                            height:
                                YoutubePlayer.getHeightFromWidth(ytWidth) - 16,
                            onDestinationSelected: (index) => context.go(
                                "/${MyRouter.courses}/${widget.courseId}?chapter=${chaptersList[index].id}"),
                            items: [
                              for (CourseChapterData chapter in chaptersList)
                                chapter.title,
                            ]),
                      ),
                    ],
                  ),
                );
              }),
              if (chapterData != null) const SizedBox(height: 100),
              if (chapterData != null) MyMarkdown(chapterData.mdContent),
            ],
          );
        },
      ),
    );
  }
}
