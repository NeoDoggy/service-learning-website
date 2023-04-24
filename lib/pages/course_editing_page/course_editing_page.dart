import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/course_editing_page_provider.dart';
import 'package:service_learning_website/test/window_size.dart';
import 'package:service_learning_website/widgets/side_menu.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';
import 'package:service_learning_website/widgets/user_icon/user_icon.dart';

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

  final List<String> _items = [
    "活動基本資訊", "行事曆", "Markdown 講義", "檔案上傳",
    "附加報名問題", "報名學生總覽", "權限設置"
  ];

  bool _loaded = false;
  int _selectedIndex = 0;
  Widget _showingWidget = const SizedBox(height: 2000, child: Placeholder());

  @override
  Widget build(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        _showingWidget = Container(height: 2000, color: Colors.red);
        break;
      case 1:
        _showingWidget = Container(height: 2000, color: Colors.orange);
        break;
      case 2:
        _showingWidget = Container(height: 2000, color: Colors.yellow);
        break;
      case 3:
        _showingWidget = Container(height: 2000, color: Colors.green);
        break;
      case 4:
        _showingWidget = Container(height: 2000, color: Colors.blue);
        break;
      case 5:
        _showingWidget = Container(height: 2000, color: Colors.blueAccent);
        break;
      case 6:
        _showingWidget = Container(height: 2000, color: Colors.purple);
        break;
    }

    return PageSkeleton(
      navigationBar: const Align(alignment: Alignment.topRight, child: UserIcon(size: 32)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<CourseEditingPageProvider>(
            builder: (context, pageProvider, child) {
              
              if (!_loaded) {
                _loaded = true;
                pageProvider.loadCourse(widget.id);
              }
              
              return TitleTextBox(pageProvider.courseData.title);
            },
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SideMenu(
                items: _items,
                onDestinationSelected: (index)
                  => setState(() => _selectedIndex = index),
              ),
              const SizedBox(width: 100),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(_items[_selectedIndex],
                      style: const TextStyle(
                        fontSize: 48,
                        height: 58 / 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    _showingWidget,
                    // Flexible(child: _showingWidget),
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