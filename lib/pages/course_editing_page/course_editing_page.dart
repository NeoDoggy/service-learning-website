import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';
import 'package:service_learning_website/pages/course_editing_page/course_editing_page_info.dart';
import 'package:service_learning_website/pages/course_editing_page/course_editing_page_permission.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/providers/courses_provider.dart';
import 'package:service_learning_website/test/window_size.dart';
import 'package:service_learning_website/widgets/permission_denied.dart';
import 'package:service_learning_website/widgets/side_menu.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';

class CourseEditingPage extends StatefulWidget {
  const CourseEditingPage(
    this.id, {
    super.key,
  });

  final String id;

  @override
  State<CourseEditingPage> createState() => _CourseEditingPageState();
}

class _CourseEditingPageState extends State<CourseEditingPage> {
  final List<String> _items = ["課程基本資訊", "課程內容", "權限設置"];

  bool _loaded = false;
  int _selectedIndex = 0;
  Widget _showingWidget = const SizedBox(height: 2000, child: Placeholder());

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if ((authProvider.userData?.permission ?? UserPermission.none) <
        UserPermission.student) {
      return const PermissionDenied();
    }

    final courseProvider = Provider.of<CoursesProvider>(context);
    if (!_loaded) {
      _loaded = true;
      courseProvider.loadCourse(widget.id);
    }
    if (courseProvider.coursesData[widget.id] == null) {
      return const Scaffold(body: Center(child: Text("Loading")));
    }

    switch (_selectedIndex) {
      case 0:
        _showingWidget = CourseEditingPageInfo(id: widget.id);
        break;
      case 1:
        _showingWidget = Container(height: 2000, color: Colors.orange);
        break;
      case 2:
        _showingWidget = CourseEditingPagePermission(id: widget.id);
        break;
    }

    return PageSkeleton(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleTextBox(courseProvider.coursesData[widget.id]?.title ?? ""),
          const SizedBox(height: 60),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SideMenu(
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
