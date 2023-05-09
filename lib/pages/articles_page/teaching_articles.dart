import 'package:flutter/material.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/widgets/articles_card.dart';
import 'package:service_learning_website/widgets/nav_bar.dart';

class TeachingArticles extends StatefulWidget {
  const TeachingArticles({super.key});

  @override
  State<TeachingArticles> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<TeachingArticles>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final ScrollController _firstController = ScrollController();

    double initheight = 800,
        initwidth = MediaQuery.of(context).size.width * 0.36;

    List<ArticleCard> AllC = [
      ArticleCard(
          Title: "文章標題標題1",
          Link: "a",
          Content: "文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點文章重點文章重點...",
          Height: initheight,
          Width: initwidth,
          Taglist: ["python", "tag"]),
      ArticleCard(
          Title: "文章標題標題2",
          Link: "b",
          Content: "文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點文章重點文章重點...",
          Height: initheight,
          Width: initwidth,
          Taglist: ["python", "tag"]),
      ArticleCard(
          Title: "文章標題標題3",
          Link: "c",
          Content: "文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點文章重點文章重點...",
          Height: initheight,
          Width: initwidth,
          Taglist: ["python", "tag"]),
      ArticleCard(
          Title: "文章標題標題4",
          Link: "d",
          Content: "文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點文章重點文章重點...",
          Height: initheight,
          Width: initwidth,
          Taglist: ["python", "tag"]),
      ArticleCard(
          Title: "文章標題標題5",
          Link: "e",
          Content: "文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點文章重點文章重點...",
          Height: initheight,
          Width: initwidth,
          Taglist: ["python", "tag"]),
      ArticleCard(
          Title: "文章標題標題6",
          Link: "f",
          Content: "文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點文章重點文章重點...",
          Height: initheight,
          Width: initwidth,
          Taglist: ["python", "tag"]),
    ];

    AllC[0].set_size(MediaQuery.of(context).size.height * 0.8,
        MediaQuery.of(context).size.width * 0.75);

    return PageSkeleton(
      body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            AllC[0],
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Wrap(
                runSpacing: MediaQuery.of(context).size.height * 0.03,
                children: [
                  Row(
                    children: [
                      Wrap(
                        spacing: MediaQuery.of(context).size.width * 0.03,
                        children: [
                          Column(children: [
                            for (int i = 1; i < AllC.length; i += 2) AllC[i]
                          ]),
                          Column(children: [
                            for (int i = 2; i < AllC.length; i += 2) AllC[i]
                          ]),
                        ],
                      ),
                    ],
                  )
                ])
          ]),
    );
  }
}
