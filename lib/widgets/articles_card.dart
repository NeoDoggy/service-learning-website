import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.title,
    required this.link,
    required this.content,
    required this.height,
    required this.width,
    required this.taglist,
  });

  final String title;
  final String link;
  final String content;
  final double height;
  final double width;
  final List<String> taglist;

  // void setSize(double height, double width) {
  //   this.height = height;
  //   this.width = width;
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushReplacement(CustomPageRoute(builder: (BuildContext context){return ArticlesPage();}));
      },
      child: SizedBox(
        height: height,
        width: width,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          color: const Color(0xFFfafafa),
          elevation: 0,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    width: width,
                    height: height * 0.6,
                    child: const Card(
                        elevation: 0,
                        color: Color.fromARGB(243, 255, 255, 255))),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 25, bottom: 25, right: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              color: Color(0xFF1f1f1f),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(width: width, child: Text(content)),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [for (String i in taglist) Text("#$i")],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
