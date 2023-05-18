import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user/user_permission.dart';
import 'package:service_learning_website/modules/my_router.dart';
import 'package:service_learning_website/providers/articles_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';

class AdminPageArticles extends StatefulWidget {
  const AdminPageArticles({super.key});

  @override
  State<AdminPageArticles> createState() => _AdminPageArticlesState();
}

class _AdminPageArticlesState extends State<AdminPageArticles> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final UserPermission permission =
            authProvider.userData?.permission ?? UserPermission.none;

        // if (permission < UserPermission.student) {
        //   return const Text("你沒有權限");
        // }

        return Consumer<ArticlesProvider>(
          builder: (context, articlesProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (permission >= UserPermission.ta)
                  ElevatedButton(
                    onPressed: () => articlesProvider.createArticle(authProvider.userData!),
                    child: const Text("新增文章"),
                  ),
                if (permission >= UserPermission.ta) const SizedBox(height: 40),
                Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      showBottomBorder: true,
                      columns: const [
                        DataColumn(label: Text("標題")),
                        DataColumn(label: Text("建立日期")),
                        DataColumn(label: Text("作者")),
                        DataColumn(label: Text("瀏覽／編輯")),
                        DataColumn(label: Text("刪除"))
                      ],
                      rows: [
                        for (var articleData
                            in articlesProvider.articlesData.values)
                          DataRow(
                            cells: [
                              DataCell(SelectableText(articleData.title)),
                              DataCell(SelectableText(DateFormat("yyyy-MM-dd")
                                  .format(articleData.createdTime))),
                              DataCell(SelectableText(articleData.authorName)),
                              DataCell(
                                IconButton(
                                  onPressed: () => context.push(
                                      "/${MyRouter.admin}/${MyRouter.articles}/${articleData.id}"),
                                  icon: (permission >= UserPermission.ta ||
                                          articleData.authorUid ==
                                              authProvider.userData!.uid)
                                      ? const Icon(Icons.edit)
                                      : const Icon(Icons.visibility),
                                ),
                              ),
                              DataCell(
                                IconButton(
                                  onPressed: (permission >= UserPermission.ta ||
                                          articleData.authorUid ==
                                              authProvider.userData!.uid)
                                      ? () => articlesProvider
                                          .deleteArticle(articleData.id)
                                      : null,
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
