import 'package:flutter/material.dart';
import 'package:service_learning_website/widgets/app_bar_g.dart';
import 'package:service_learning_website/widgets/ClassCard.dart';
import 'package:service_learning_website/widgets/NavBar.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<FavPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final ScrollController _firstController = ScrollController();

    List<ClassCard> AllC = [
      ClassCard(Name: "服學課程", Student: "大一新生", Where: "工五A204", Add_In: true),
      ClassCard(Name: "服學課程", Student: "大一新生", Where: "工五A204", Add_In: false),
      ClassCard(Name: "服學課程", Student: "大一新生", Where: "工五A204", Add_In: true),
      ClassCard(Name: "服學課程", Student: "大一新生", Where: "工五A204", Add_In: true),
      ClassCard(Name: "服學課程", Student: "大一新生", Where: "工五A204", Add_In: true),
      ClassCard(Name: "服學課程", Student: "大一新生", Where: "工五A204", Add_In: true),
      ClassCard(Name: "服學課程", Student: "大一新生", Where: "工五A204", Add_In: true),
    ];

    return Scaffold(
        drawer: NavBar(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              AppBarG(),
            ];
          },
          body: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              '最愛課程',
                              style:
                                  TextStyle(color: Color(0xFF474747), fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              spacing: 10.0,
                              runSpacing: 10.0,
                              children: [
                                for(ClassCard i in AllC) i,
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        width: double.maxFinite,
                        height: 100,
                        color: Color(0xFFf5f5f5),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Center(child: SelectableText("單位：國立中央大學資訊工程學系\n地址：(320317) 桃園市中壢區中大路300號\n聯絡電話：03-422-7151\nemail：ncu4500@ncu.edu.tw")),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
    );
  }
}
