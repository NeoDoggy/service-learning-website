import 'package:flutter/material.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';
import 'package:service_learning_website/test/window_size.dart';

class BackstagePage extends StatefulWidget {
  const BackstagePage({super.key});

  @override
  State<BackstagePage> createState() => _BackstagePageState();
}

class _BackstagePageState extends State<BackstagePage> {
  @override
  Widget build(BuildContext context) {
    return PageSkeleton(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TitleTextBox("我的營隊", width: 275),
          SizedBox(height: 60),
          SizedBox(height: 60),
          TitleTextBox("我的課程", width: 275),
          SizedBox(height: 60),
          SizedBox(height: 60),
          //   mainAxisSize: MainAxisSize.min,
        ],
      ),
      bottomSheet: const WindowSize(),
    );
  }
}
