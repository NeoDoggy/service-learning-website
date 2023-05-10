import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/course_data.dart';
import 'package:service_learning_website/modules/my_router.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/courses_provider.dart';
import 'package:service_learning_website/widgets/online_course_card.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';

class CourseBrowsingPage extends StatelessWidget {
  const CourseBrowsingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageSkeleton(
      body: Consumer<CoursesProvider>(
        builder: (context, coursesProvider, child) {
          final coursesData = coursesProvider.coursesData;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleTextBox("線上課程"),
              const SizedBox(height: 60),
              LayoutBuilder(builder: (context, constraint) {
                const double cardWidth = 350;
                final colWidth = constraint.maxWidth;
                int cardCount;
                for (cardCount = 0;
                    colWidth >= cardWidth * (cardCount + 1) + 60 * cardCount;
                    cardCount++) {}
                return Wrap(
                  spacing: (colWidth - cardWidth * cardCount) / (cardCount - 1),
                  runSpacing: 60,
                  children: [
                    for (CourseData courseData in coursesData.values)
                      OnlineCourseCard(
                        onTap: () => context.go(
                            "/${MyRouter.courses}/${courseData.id}/${MyRouter.intro}"),
                        width: cardWidth,
                        imageUrl: courseData.imageUrl,
                        courseName: courseData.title,
                      )
                  ],
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
