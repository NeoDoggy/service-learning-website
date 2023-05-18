import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/articles_provider.dart';
import 'package:service_learning_website/widgets/articles_card.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';

class ArticlesBrowsingPage extends StatefulWidget {
  const ArticlesBrowsingPage({super.key});

  @override
  State<ArticlesBrowsingPage> createState() => _ArticlesBrowsingPageState();
}

class _ArticlesBrowsingPageState extends State<ArticlesBrowsingPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return PageSkeleton(
      body: Consumer<ArticlesProvider>(
        builder: (context, articlesProvider, child) {
          final articlesDataList =
              articlesProvider.articlesData.values.toList();
          articlesDataList
              .sort((a, b) => a.createdTime.compareTo(b.createdTime));

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleTextBox("教學文章"),
              const SizedBox(height: 60),
              if (articlesDataList.isNotEmpty)
                ArticleCard(
                    articleData: articlesDataList[0],
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.75),
              if (articlesDataList.isNotEmpty) const SizedBox(height: 60),
              Wrap(runSpacing: 60, children: [
                Row(
                  children: [
                    Wrap(
                      spacing: 60,
                      children: [
                        Column(children: [
                          for (int i = 1; i < articlesDataList.length; i += 2)
                            ArticleCard(
                              articleData: articlesDataList[i],
                              height: 800,
                              width: MediaQuery.of(context).size.width * 0.36,
                            )
                        ]),
                        Column(children: [
                          for (int i = 2; i < articlesDataList.length; i += 2)
                            ArticleCard(
                              articleData: articlesDataList[i],
                              height: 800,
                              width: MediaQuery.of(context).size.width * 0.36,
                            )
                        ]),
                      ],
                    ),
                  ],
                )
              ])
            ],
          );
        },
      ),
    );
  }
}
