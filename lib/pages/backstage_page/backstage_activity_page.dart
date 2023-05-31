import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/pages/backstage_page/backstage_activity_page_file.dart';
import 'package:service_learning_website/pages/backstage_page/backstage_activity_page_photo.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/widgets/my_markdown.dart';
import 'package:service_learning_website/widgets/side_menu.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';

class BackstageActivityPage extends StatefulWidget {
  const BackstageActivityPage(
    this.activityId, {
    super.key,
  });

  final String activityId;

  @override
  State<BackstageActivityPage> createState() => _BackstageActivityPageState();
}

class _BackstageActivityPageState extends State<BackstageActivityPage> {
  final List<String> _items = [
    "課程講義",
    "檔案下載",
    "活動照片",
    // "活動說明",
  ];

  bool _loaded = false;
  int _selectedWidgetIndex = 0;
  int _selectedLectureIndex = 0;
  Widget _showingWidget = const SizedBox(height: 2000, child: Placeholder());

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.userData == null) {
      return const Scaffold(body: Center(child: Text("Loading")));
    }

    final activitiesProvider = Provider.of<ActivitiesProvider>(context);
    final activityData = activitiesProvider.activitiesData[widget.activityId];
    if (!_loaded) {
      _loaded = true;
      activitiesProvider.loadActivity(widget.activityId);
    }
    if (activityData == null) {
      return const Scaffold(body: Center(child: Text("Loading")));
    }
    final lecturesList = activityData.lectures.values.toList();
    lecturesList.sort((a, b) => a.number.compareTo(b.number));

    switch (_selectedWidgetIndex) {
      case 0:
        _showingWidget = _selectedLectureIndex < lecturesList.length
            ? MyMarkdown(lecturesList[_selectedLectureIndex].mdContent)
            : const MyMarkdown("");
        break;
      case 1:
        _showingWidget = BackstageActivityPageFile(widget.activityId);
        break;
      case 2:
        _showingWidget = BackstageActivityPagePhoto(widget.activityId);
        break;
      // case 3:
      //   _showingWidget = BackstageActivityPageInfo(widget.activityId);
      //   break;
    }

    return PageSkeleton(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleTextBox(
              activitiesProvider.activitiesData[widget.activityId]?.title ??
                  ""),
          const SizedBox(height: 60),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SideMenu(
                    width: 260,
                    items: _items,
                    onDestinationSelected: (index) =>
                        setState(() => _selectedWidgetIndex = index),
                  ),
                  if (_selectedWidgetIndex == 0) const SizedBox(height: 60),
                  if (_selectedWidgetIndex == 0)
                    SideMenu(
                      width: 260,
                      items: lecturesList.map((e) => e.title).toList(),
                      onDestinationSelected: (index) =>
                          setState(() => _selectedLectureIndex = index),
                    ),
                ],
              ),
              const SizedBox(width: 100),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _items[_selectedWidgetIndex],
                      style: const TextStyle(
                        fontSize: 48,
                        height: 58 / 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    _showingWidget,
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
