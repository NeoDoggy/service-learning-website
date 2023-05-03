import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:like_button/like_button.dart';
import 'package:service_learning_website/AppStates/MyAppState.dart';
import 'package:service_learning_website/widgets/app_bar_g.dart';
import 'package:service_learning_website/widgets/BigCard.dart';
import 'package:service_learning_website/widgets/ClassCard.dart';
import 'package:service_learning_website/widgets/NavBar.dart';

class MainTestPage extends StatefulWidget {
  const MainTestPage({super.key});

  @override
  State<MainTestPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MainTestPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  // final String title;
  final ScrollController _firstController = ScrollController();
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MainAppState>();
    var card = appState.current;
    IconData icon;
    if (appState.favorites.contains(card)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }
    TabController _tabController = TabController(length: 4, vsync: this);

    List<ClassCard> AddC = [
      ClassCard(Name: "服學課程", Student: "大一新生", Where: "工五A204", Add_In: false),
      ClassCard(Name: "測試課程", Student: "大一新生", Where: "工五A204", Add_In: false),
    ];
    List<ClassCard> NadC = [
      ClassCard(Name: "服學課程", Student: "大一新生", Where: "工五A204", Add_In: true),
      ClassCard(Name: "服學課程", Student: "大一新生", Where: "工五A204", Add_In: true),
      ClassCard(Name: "服學課程", Student: "大一新生", Where: "工五A204", Add_In: true),
      ClassCard(Name: "服學課程", Student: "大一新生", Where: "工五A204", Add_In: true),
      ClassCard(Name: "服學課程", Student: "大一新生", Where: "工五A204", Add_In: true),
    ];
    List<List<Widget>> AllC = [AddC,NadC];

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
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: TabBar(
                                  overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                  isScrollable: true,
                                  labelColor: Color(0xFF474747),
                                  unselectedLabelColor: Color(0xFFadadad),
                                  controller: _tabController,
                                  indicatorColor: Colors.transparent,
                                  indicator: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(width: 4, color: Color(0xFF00ba7c)),
                                      // bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
                                    ),
                                  ),
                                  tabs: [
                                    Tab(
                                      icon: Row(
                                        children: [
                                          Icon(Icons.home),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("課程總覽"),
                                        ],
                                      ),
                                    ),
                                    Tab(
                                      icon: Row(
                                        children: [
                                          Icon(Icons.web),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("練習題庫"),
                                        ],
                                      ),
                                    ),
                                    Tab(
                                      icon: Row(
                                        children: [
                                          Icon(Icons.home),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("我的課程"),
                                        ],
                                      ),
                                    ),
                                    Tab(
                                      icon: Row(
                                        children: [
                                          Icon(Icons.home),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("其他"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              height: MediaQuery.of(context).size.height,
                              child: TabBarView(controller: _tabController,children: [
                                ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                  child: SingleChildScrollView(
                                    child: Container(
                                      // padding: EdgeInsets.only(left: 50, right: 50),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            '已加入',
                                            style: TextStyle(
                                                color: Color(0xFF474747), fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            child: Wrap(
                                              spacing: 10.0,
                                              runSpacing: 10.0,
                                              children: AllC[0],
                                            ),
                                          ),
                                          Divider(),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            '未加入',
                                            style: TextStyle(
                                                color: Color(0xFF474747), fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            child: Wrap(
                                              spacing: 10.0,
                                              runSpacing: 10.0,
                                              children: AllC[1],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 50, right: 50),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // Below are for Wrap
                                    // direction: Axis.horizontal,
                                    // spacing: 0, // gap between adjacent chips
                                    // runSpacing: 0, // gap between lines
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '文章',
                                        style: TextStyle(
                                            color: Color(0xFFFFFFFF), fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        //padding: EdgeInsets.only(left: 50),
                                        child: Column(
                                          children: [
                                            BigCard(card: card),
                                            BigCard(card: card),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 50, right: 50),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // Below are for Wrap
                                    // direction: Axis.horizontal,
                                    // spacing: 0, // gap between adjacent chips
                                    // runSpacing: 0, // gap between lines
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '文章',
                                        style: TextStyle(
                                            color: Color(0xFFFFFFFF), fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        //padding: EdgeInsets.only(left: 50),
                                        child: Column(
                                          children: [
                                            BigCard(card: card),
                                            BigCard(card: card),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 50, right: 50),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // Below are for Wrap
                                    // direction: Axis.horizontal,
                                    // spacing: 0, // gap between adjacent chips
                                    // runSpacing: 0, // gap between lines
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '最新活動',
                                        style: TextStyle(
                                            color: Color(0xFF474747), fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      ShaderMask(
                                        shaderCallback: (Rect rect) {
                                          return LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              Color(0xFF1f1f1f),
                                              Colors.transparent,
                                              Colors.transparent,
                                              Color(0xFF1f1f1f)
                                            ],
                                            stops: [0.0, 0.01, 0.95, 1],
                                          ).createShader(rect);
                                        },
                                        blendMode: BlendMode.dstOut,
                                        child: Container(
                                          height: 180,
                                          // padding: EdgeInsets.only(right: 5),
                                          child: Scrollbar(
                                            thumbVisibility: true,
                                            controller: _firstController,
                                            child: Container(
                                              height: 180,
                                              child: ListView.builder(
                                                controller: _firstController,
                                                scrollDirection: Axis.horizontal,
                                                itemCount: 5,
                                                itemBuilder:
                                                    (BuildContext context, int index) {
                                                  return Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(5),
                                                        color: Color(0xFFffffff),
                                                      ),
                                                      width: 400,
                                                      height: 180,
                                                      padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                      child: Container(
                                                        height: 180,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                          mainAxisSize:
                                                          MainAxisSize.min,
                                                          children: [
                                                            BigCard(card: card),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              children: [
                                                                SizedBox(width: 10),
                                                                LikeButton(
                                                                  size: 25,
                                                                  isLiked: isLiked,
                                                                  likeBuilder:
                                                                      (isLiked) {
                                                                    final color = isLiked
                                                                        ? Color(
                                                                        0xFFff4060)
                                                                        : Color(
                                                                        0xFF1f1f1f);
                                                                    return Icon(
                                                                        isLiked
                                                                            ? Icons
                                                                            .favorite
                                                                            : Icons
                                                                            .favorite_border,
                                                                        color: color,
                                                                        size: 25);
                                                                  },
                                                                  circleColor:
                                                                  const CircleColor(
                                                                      start: Color(
                                                                          0xFFff4060),
                                                                      end: Color(
                                                                          0xFFff4060)),
                                                                  bubblesColor:
                                                                  const BubblesColor(
                                                                    dotPrimaryColor:
                                                                    Color(
                                                                        0xFFff4060),
                                                                    dotSecondaryColor:
                                                                    Color(
                                                                        0xFFff4060),
                                                                  ),
                                                                  onTap:
                                                                      (isLiked) async {
                                                                    this.isLiked =
                                                                    !isLiked;
                                                                    this.isLiked
                                                                        ? appState
                                                                        .addFavorite()
                                                                        : appState
                                                                        .delFavorite();
                                                                    return !isLiked;
                                                                  },
                                                                ),
                                                                Spacer(),
                                                                //SizedBox(width: 10),
                                                                ElevatedButton(
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    minimumSize:
                                                                    Size.zero,
                                                                    padding:
                                                                    EdgeInsets.all(
                                                                        0),
                                                                  ),
                                                                  onPressed: () {
                                                                    this.isLiked =
                                                                    false;
                                                                    appState.getNext();
                                                                    //appState.listCur();
                                                                  },
                                                                  child:
                                                                  AnimatedContainer(
                                                                    // transform: Matrix4.rotationZ(360),
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          3),
                                                                      color: isLiked
                                                                          ? Color(
                                                                          0xFF00ba7c)
                                                                          : Color(
                                                                          0xFF0096fa),
                                                                    ),
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                        15,
                                                                        vertical:
                                                                        6),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                        500),
                                                                    child: Center(
                                                                      child: Text(
                                                                        'Next',
                                                                        style:
                                                                        TextStyle(
                                                                          color: Color(
                                                                              0xFFFFFFFF),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(width: 10),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ],),
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
                          child: Center(child: Text("單位：國立中央大學資訊工程學系\n地址：(320317) 桃園市中壢區中大路300號\n聯絡電話：03-422-7151\nemail：ncu4500@ncu.edu.tw")),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },

          )
        ));
  }
}
