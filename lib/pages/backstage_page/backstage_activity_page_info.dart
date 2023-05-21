import 'package:flutter/material.dart';

class BackstageActivityPageInfo extends StatefulWidget {
  const BackstageActivityPageInfo(
    this.activityId, {
    super.key,
  });

  final String activityId;

  @override
  State<BackstageActivityPageInfo> createState() =>
      _BackstageActivityPageInfoState();
}

class _BackstageActivityPageInfoState extends State<BackstageActivityPageInfo> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
