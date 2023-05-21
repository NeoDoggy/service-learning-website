import 'package:flutter/material.dart';

class BackstageActivityPageLecture extends StatefulWidget {
  const BackstageActivityPageLecture(
    this.activityId, {
    super.key,
  });

  final String activityId;

  @override
  State<BackstageActivityPageLecture> createState() =>
      _BackstageActivityPageLectureState();
}

class _BackstageActivityPageLectureState
    extends State<BackstageActivityPageLecture> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
