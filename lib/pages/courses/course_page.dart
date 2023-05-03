import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/my_router.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/providers/courses_provider.dart';
import 'package:service_learning_website/widgets/my_progress_bar.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';
import 'package:service_learning_website/widgets/youtube_player.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({
    super.key,
    required this.courseId,
  });

  final String courseId;

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  bool _loaded = false;
  bool _loading = true;
  bool _isParticipant = false;
  double _ytWidth = 0;

  @override
  Widget build(BuildContext context) {
    return PageSkeleton(
      body: Consumer2<AuthProvider, CoursesProvider>(
        builder: (context, authProvider, coursesProvider, child) {
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

          _isParticipant = courseData.participants[userData?.uid ?? ""] != null;

          if (!_isParticipant) {
            WidgetsBinding.instance.addPostFrameCallback((_) => context.go(
                "/${MyRouter.courses}/${widget.courseId}/${MyRouter.intro}"));
            return const Center(child: Text("Loading"));
          }

          final participantData = courseData.participants[userData!.uid]!;

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
              LayoutBuilder(
                builder: (context, constraint) {
                  final height = (constraint.maxWidth - 60) / 4 * 3 / 16 * 9;
                  return Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 3,
                        child: LayoutBuilder(
                          builder: (context, ytConstraint) {
                            final ytKey = GlobalKey();
                            return YoutubePlayer(
                              key: ytKey,
                              width: ytConstraint.maxWidth,
                              height: height,
                              url: "https://www.youtube.com/watch?v=yMMibCohcCk",
                            );
                          }
                        ),
                      ),
                      const SizedBox(width: 60),
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: height,
                          decoration: const BoxDecoration(color: Colors.blue),
                        ),
                      ),
                    ],
                  );
                }
              ),
            ],
          );
        },
      ),
    );
  }
}
