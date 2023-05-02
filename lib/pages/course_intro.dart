// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/courses_provider.dart';
import 'package:service_learning_website/widgets/course_name_box.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';

class CourseIntro extends StatefulWidget {
  const CourseIntro({
    super.key,
    required this.courseId,
    // required this.imagePath,
    // required this.courseName,
    // required this.introCtx,
  });

  // final String imagePath;
  // final String courseName;
  // final String introCtx;
  final String courseId;

  @override
  State<CourseIntro> createState() => _CourseIntroState();
}

class _CourseIntroState extends State<CourseIntro> {
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    final coursesProvider = Provider.of<CoursesProvider>(context);
    if (!_loaded) {
      _loaded = true;
      coursesProvider.loadCourse(widget.courseId);
    }
    if (coursesProvider.coursesData[widget.courseId] == null) {
      return const Scaffold(body: Center(child: Text("Loading")));
    }

    return PageSkeleton(
      body:
          Consumer<CoursesProvider>(builder: (context, coursesProvider, child) {
        final courseData = coursesProvider.coursesData[widget.courseId]!;

        return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleTextBox(courseData.title),
              const SizedBox(height: 60),
              Row(children: []),
            ]);
      }),
    );
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       Expanded(
    //         child: _Body(
    //             courseName: courseName,
    //             imagePath: imagePath,
    //             introCtx: introCtx),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class _Body extends StatelessWidget {
  final String imagePath;
  final String courseName;
  final String introCtx;

  const _Body(
      {Key? key,
      required this.imagePath,
      required this.courseName,
      required this.introCtx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).size.width / 1440.0;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100.0 * scale),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 1440.0 * scale,
              height: 60.0 * scale,
            ),
            CourseNameBox(
              coursename: courseName,
            ),
            SizedBox(
              width: 1440.0 * scale,
              height: 60.0 * scale,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: 387.0 * scale,
                    height: 471.0 * scale,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100.0 * scale,
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: 753.0 * scale,
                    child: Text(
                      introCtx,
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 32.0 * scale,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80.0 * scale,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 1000.0 * scale,
                  height: 77.0 * scale,
                ),
                ElevatedButton(
                  onPressed: () {
                    // 當按下時要跳到一個頁面
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xff1f6afb),
                    backgroundColor: Color(0xff1f6afb),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    minimumSize: Size(240.0 * scale, 77.0 * scale),
                  ),
                  child: Text(
                    '進入課程',
                    style: TextStyle(
                      fontSize: 32.0 * scale,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100.0 * scale,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
