// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, no_logic_in_create_state

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/my_router.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/providers/courses_provider.dart';
import 'package:service_learning_website/widgets/my_markdown.dart';
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
  final _subTitleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  final _contentStyle = TextStyle(fontSize: 16);

  Uint8List? _imageByte;
  bool _loaded = false;
  bool _isParticipant = false;

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
      body: Consumer2<AuthProvider, CoursesProvider>(
        builder: (context, authProvider, coursesProvider, child) {
          final userData = authProvider.userData;
          final courseData = coursesProvider.coursesData[widget.courseId]!;

          _isParticipant = courseData.participants[userData?.uid ?? ""] != null;

          if (_imageByte == null && courseData.imageUrl != "") {
            http
                .get(Uri.parse(courseData.imageUrl))
                .timeout(const Duration(seconds: 5))
                .then((response) =>
                    setState(() => _imageByte = response.bodyBytes))
                .catchError((_) => setState(() => _imageByte = null));
          }

          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleTextBox(courseData.title),
                const SizedBox(height: 60),
                Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_imageByte != null)
                        Image.memory(_imageByte!, width: 400),
                      if (_imageByte == null)
                        const SizedBox(width: 400, child: Placeholder()),
                      const SizedBox(width: 100),
                      Flexible(
                        child: SelectionArea(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.description),
                                    SizedBox(width: 10),
                                    Text("課程介紹", style: _subTitleStyle),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Text(courseData.description,
                                    style: _contentStyle),
                                const SizedBox(height: 40),
                                Row(
                                  children: [
                                    Icon(Icons.people),
                                    SizedBox(width: 10),
                                    Text("適合對象", style: _subTitleStyle),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Text(courseData.audience, style: _contentStyle),
                                const SizedBox(height: 40),
                                Row(
                                  children: [
                                    Icon(Icons.computer),
                                    SizedBox(width: 10),
                                    Text("開發環境", style: _subTitleStyle),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Text(courseData.environment,
                                    style: _contentStyle),
                                const SizedBox(height: 40),
                                Row(
                                  children: [
                                    Icon(Icons.list),
                                    SizedBox(width: 10),
                                    Text("課程大綱", style: _subTitleStyle),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                MyMarkdown(courseData.outline,
                                    selectable: false),
                                const SizedBox(height: 40),
                              ]),
                        ),
                      ),
                    ]),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (!authProvider.isAuthed) {
                          context.push("/${MyRouter.login}");
                        } else {
                          if (!_isParticipant) {
                            await coursesProvider.addParticipant(
                                widget.courseId, authProvider.userData!.uid);
                          }
                          if (context.mounted) {
                            context.push(
                                "/${MyRouter.courses}/${widget.courseId}");
                          }
                        }
                      },
                      style: ButtonStyle(
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 24)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                      ),
                      child: Text(_isParticipant ? "進入課程" : "加入課程")),
                ),
              ]);
        },
      ),
    );
  }
}
/*
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
*/