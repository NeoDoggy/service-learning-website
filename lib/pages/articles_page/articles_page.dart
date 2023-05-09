import 'package:flutter/material.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/widgets/my_markdown.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ArticlesPage>
    with TickerProviderStateMixin {
  final String markdownData = """
# Title
## Subtitle
aaaa
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
- 这是另一个列表项
- 这是一个列表项
""";
  @override
  Widget build(BuildContext context) {
    final ScrollController _firstController = ScrollController();
    return PageSkeleton(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleTextBox("一階ODE Homogeneous 與 non-Homogeneous"),
          SizedBox(height: 60),
          MyMarkdown(markdownData)
        ],
      ),
    );
  }
}
