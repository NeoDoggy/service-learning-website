import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/articles_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';

class ArticleEditingPage extends StatefulWidget {
  const ArticleEditingPage(this.articleId, {super.key});

  final String articleId;

  @override
  State<ArticleEditingPage> createState() => _ArticleEditingPageState();
}

class _ArticleEditingPageState extends State<ArticleEditingPage> {
  final _titleTextController = TextEditingController();
  final _introductionTextController = TextEditingController();
  final _mdContentTextController = TextEditingController();

  bool _canEdit = false;
  bool _isEdited = false;
  bool _imageEdited = false;
  Uint8List? _imageByte;

  @override
  void dispose() {
    _titleTextController.dispose();
    _introductionTextController.dispose();
    _mdContentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if ((authProvider.userData?.permission ?? UserPermission.none) <
        UserPermission.student) {
      return const Scaffold(body: Center(child: Text("Permission denied")));
    }

    final articlesProvider = Provider.of<ArticlesProvider>(context);
    if (articlesProvider.articlesData[widget.articleId] == null) {
      return const Scaffold(body: Center(child: Text("Loading")));
    }

    return PageSkeleton(body: Consumer2<AuthProvider, ArticlesProvider>(
      builder: (context, authProvider, coursesProvider, child) {
        final articleData = coursesProvider.articlesData[widget.articleId]!;
        _canEdit = (authProvider.userData?.permission ?? UserPermission.none) >=
                UserPermission.ta ||
            articleData.authorUid == authProvider.userData?.uid;

        if (!_isEdited) {
          _titleTextController.text = articleData.title;
          _introductionTextController.text = articleData.introduction;
          _mdContentTextController.text = articleData.mdContent;
          if (_imageByte == null && articleData.imageUrl != "") {
            http
                .get(Uri.parse(articleData.imageUrl))
                .timeout(const Duration(seconds: 5))
                .then((response) =>
                    setState(() => _imageByte = response.bodyBytes))
                .catchError((_) => setState(() => _imageByte = null));
          }
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleTextBox(articleData.title),
            const SizedBox(height: 60),
            if (_isEdited)
              ElevatedButton(
                  onPressed: () {
                    articleData.title = _titleTextController.text;
                    articleData.introduction = _introductionTextController.text;
                    articleData.mdContent = _mdContentTextController.text;
                    coursesProvider.updateArticle(widget.articleId,
                        image: _imageEdited ? _imageByte : null);
                    setState(() => _isEdited = false);
                  },
                  child: const Text("儲存變更")),
            if (_isEdited) const SizedBox(height: 40),
            TextField(
              readOnly: !_canEdit,
              controller: _titleTextController,
              onChanged: (_) => setState(() => _isEdited = true),
              decoration: const InputDecoration(
                labelText: "文章標題",
                icon: Icon(Icons.text_fields),
              ),
            ),
            TextField(
              readOnly: !_canEdit,
              controller: _introductionTextController,
              onChanged: (_) => setState(() => _isEdited = true),
              decoration: const InputDecoration(
                labelText: "文章摘要預覽",
                icon: Icon(Icons.preview),
              ),
            ),
            TextField(
              readOnly: !_canEdit,
              controller: _mdContentTextController,
              onChanged: (_) => setState(() => _isEdited = true),
              maxLines: null,
              decoration: const InputDecoration(
                labelText: "Markdown 文章內容",
                hintText: "使用 Markdown 語法，可多換行輸入",
                icon: Icon(Icons.description),
              ),
            ),
            const SizedBox(height: 40),
            Row(children: [
              const Text("課程預覽圖片"),
              if (_canEdit) const SizedBox(width: 10),
              if (_canEdit)
                ElevatedButton(
                    onPressed: () => _pickFile(), child: const Text("瀏覽檔案")),
            ]),
            const SizedBox(height: 20),
            if (_imageByte != null) Image.memory(_imageByte!, width: 400),
            if (_imageByte == null)
              const SizedBox(width: 400, child: Placeholder()),
          ],
        );
      },
    ));
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      setState(() {
        _imageByte = result.files.first.bytes;
        _isEdited = true;
        _imageEdited = true;
      });
    }
  }
}
