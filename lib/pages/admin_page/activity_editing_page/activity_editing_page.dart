import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user/user_permission.dart';
import 'package:service_learning_website/pages/admin_page/activity_editing_page/acrivity_editing_page_permission.dart';
import 'package:service_learning_website/pages/admin_page/activity_editing_page/activity_editing_page_calendar.dart';
import 'package:service_learning_website/pages/admin_page/activity_editing_page/activity_editing_page_info.dart';
import 'package:service_learning_website/pages/admin_page/activity_editing_page/activity_editing_page_question.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/test/window_size.dart';
import 'package:service_learning_website/widgets/side_menu.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';

class ActivityEditingPage extends StatefulWidget {
  const ActivityEditingPage(
    this.id, {
    super.key,
  });

  final String id;

  @override
  State<ActivityEditingPage> createState() => _ActivityEditingPageState();
}

class _ActivityEditingPageState extends State<ActivityEditingPage> {
  final List<String> _items = [
    "營隊基本資訊",
    "行事曆",
    "附加報名問題",
    "講義上傳",
    "檔案上傳",
    "活動照片",
    "已報名學生",
    "權限設置",
  ];

  bool _loaded = false;
  int _selectedIndex = 0;
  Widget _showingWidget = const SizedBox(height: 2000, child: Placeholder());

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if ((authProvider.userData?.permission ?? UserPermission.none) <
        UserPermission.student) {
      return const Scaffold(body: Center(child: Text("Permission denied")));
    }

    final activitiesProvider = Provider.of<ActivitiesProvider>(context);
    if (!_loaded) {
      _loaded = true;
      activitiesProvider.loadActivity(widget.id);
    }
    if (activitiesProvider.activitiesData[widget.id] == null) {
      return const Scaffold(body: Center(child: Text("Loading")));
    }

    switch (_selectedIndex) {
      case 0:
        _showingWidget = ActivityEditingPageInfo(widget.id);
        break;
      case 1:
        _showingWidget = ActivityEditingPageCalendar(widget.id);
        break;
      case 2:
        _showingWidget = ActivityEditingPageQuestion(widget.id);
        break;
      case 3:
        _showingWidget = Container(height: 2000, color: Colors.orange);
        break;
      case 4:
        _showingWidget = Container(height: 2000, color: Colors.yellow);
        break;
      case 5:
        _showingWidget = Container(height: 2000, color: Colors.green);
        break;
      case 6:
        _showingWidget = Container(height: 2000, color: Colors.blue);
        break;
      case 7:
        _showingWidget = ActivityEditingPagePermission(widget.id);
        break;
    }

    return PageSkeleton(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleTextBox(activitiesProvider.activitiesData[widget.id]?.title ?? ""),
          const SizedBox(height: 60),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SideMenu(
                width: 260,
                items: _items,
                onDestinationSelected: (index) =>
                    setState(() => _selectedIndex = index),
              ),
              const SizedBox(width: 100),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _items[_selectedIndex],
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
      bottomSheet: const WindowSize(),
    );
  }
}
