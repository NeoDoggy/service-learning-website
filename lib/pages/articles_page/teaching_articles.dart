import 'package:flutter/material.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/widgets/articles_card.dart';

class TeachingArticles extends StatefulWidget {
  const TeachingArticles({super.key});

  @override
  State<TeachingArticles> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<TeachingArticles>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {

    double initheight = 800,
        initwidth = MediaQuery.of(context).size.width * 0.36;

    List<ArticleCard> allc = [
      ArticleCard(
          title: "文章標題標題1",
          link: "a",
          content: "文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點文章重點文章重點...",
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.75,
          taglist: const ["python", "tag"]),
      ArticleCard(
          title: "文章標題標題2",
          link: "b",
          content: "文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點文章重點文章重點...",
          height: initheight,
          width: initwidth,
          taglist: const ["python", "tag"]),
      ArticleCard(
          title: "文章標題標題3",
          link: "c",
          content: "文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點文章重點文章重點...",
          height: initheight,
          width: initwidth,
          taglist: const ["python", "tag"]),
      ArticleCard(
          title: "文章標題標題4",
          link: "d",
          content: "文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點文章重點文章重點...",
          height: initheight,
          width: initwidth,
          taglist: const ["python", "tag"]),
      ArticleCard(
          title: "文章標題標題5",
          link: "e",
          content: "文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點文章重點文章重點...",
          height: initheight,
          width: initwidth,
          taglist: const ["python", "tag"]),
      ArticleCard(
          title: "文章標題標題6",
          link: "f",
          content: "文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點節錄文章重點文章重點文章重點...",
          height: initheight,
          width: initwidth,
          taglist: const ["python", "tag"]),
    ];

    // allc[0].setSize(MediaQuery.of(context).size.height * 0.8,
    //     MediaQuery.of(context).size.width * 0.75);

    return PageSkeleton(
      body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            allc[0],
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
                            for (int i = 1; i < allc.length; i += 2) allc[i]
                          ]),
                          Column(children: [
                            for (int i = 2; i < allc.length; i += 2) allc[i]
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
