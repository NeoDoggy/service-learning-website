import 'package:flutter/material.dart';
import 'package:service_learning_website/widgets/AppBar.dart';
import 'package:service_learning_website/widgets/Footer.dart';
import 'package:service_learning_website/widgets/NavBar.dart';
import 'package:service_learning_website/widgets/OpinionCard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<WelcomePage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final ScrollController _firstController = ScrollController();

    List<OpinonCard> OPC = [
      OpinonCard(said: "hahapiyan"),
      OpinonCard(said: "hehepiyan"),
    ];

    return Scaffold(
      drawer: NavBar(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            AppBar_G(),
          ];
        },
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // decoration: const BoxDecoration(
                      //   image: DecorationImage(
                      //     image: AssetImage('../images/helloIMG3.png'),
                      //     colorFilter: ColorFilter.mode(
                      //         Color(0x9F000000), BlendMode.darken),
                      //     repeat: ImageRepeat.repeat,
                      //   ),
                      // ),
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height - 56,
                      child: Column(
                        children: [
                          SizedBox(height: 120,),
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(left: 100,right: 100),
                              height: 450,
                              width: 1000,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                color: Color(0xFF1F6AFB),
                                elevation: 0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("中央資訊教育平台",style: TextStyle(fontSize: 75,color: Color(0xFFFFFFFF)),),
                                    SizedBox(height: 75,),
                                    Text("NCU Computer Science Tutorial Platform",style: TextStyle(fontSize: 24,color: Color(0xFFFFFFFF)),),
                                  ],
                                ),
                              ),
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  new BoxShadow(
                                    color: Color(0x30474747),
                                    blurRadius: 100.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 120,),
                          Icon(Icons.expand_more_outlined,color: Color(0xFF000000),size: 32,)
                        ],
                      ),
                    ),
                    Container(
                      // decoration: const BoxDecoration(
                      //   image: DecorationImage(
                      //     image: AssetImage('../images/Wong2.png'),
                      //     colorFilter: ColorFilter.mode(
                      //         Color(0x9F000000), BlendMode.darken),
                      //     repeat: ImageRepeat.repeat,
                      //   ),
                      // ),
                      color: Color(0xFFF2F4FF),
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height,
                      child: Container(
                        padding: EdgeInsets.only(left: 100,right: 100,top: 50),
                        height: 450,
                        width: 1000,
                        child: Column(
                          children: [
                            Text("關於我們",style: TextStyle(fontSize: 64,color: Color(0xFF000000)),),
                            SizedBox(height: 20,),
                            Text("「中央資訊教育平台」是由中央大學資工系同學所架設的網頁平台，以推廣程式設計、資訊科學素養為目標，讓有興趣接觸這塊領域的同學，能透過本平台報名營隊活動或是加入線上課程，探索學習相關知識，我們也歡迎學校或其他單位與我們合作！",style: TextStyle(fontSize: 24,color: Color(0xFF000000)),),
                            SizedBox(height: 20,),
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10))),
                                      color: Color(0xFF0A2472),
                                      elevation: 0,
                                      child: Container(
                                        width: 500,
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(60),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Icon(Icons.diversity_3_outlined  ,color: Color(0xFFFFFFFF),size: 75,),
                                                SizedBox(width: 60,),
                                                Text("營隊活動",style: TextStyle(fontSize: 36,color: Color(0xFFFFFFFF)),),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 40,),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10))),
                                      color: Color(0xFF0A2472),
                                      elevation: 0,
                                      child: Container(
                                        width: 500,
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(60),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Icon(Icons.help_outline_outlined ,color: Color(0xFFFFFFFF),size: 75,),
                                                SizedBox(width: 60,),
                                                Text("常見問題",style: TextStyle(fontSize: 36,color: Color(0xFFFFFFFF)),),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 60,),
                                Column(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10))),
                                      color: Color(0xFF0A2472),
                                      elevation: 0,
                                      child: Container(
                                        width: 500,
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(60),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Icon(Icons.data_object_outlined ,color: Color(0xFFFFFFFF),size: 75,),
                                                SizedBox(width: 60,),
                                                Text("教學文章",style: TextStyle(fontSize: 36,color: Color(0xFFFFFFFF)),),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 40,),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10))),
                                      color: Color(0xFF0A2472),
                                      elevation: 0,
                                      child: Container(
                                        width: 500,
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(60),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Icon(Icons.connected_tv_outlined ,color: Color(0xFFFFFFFF),size: 75,),
                                                SizedBox(width: 60,),
                                                Text("線上課程",style: TextStyle(fontSize: 36,color: Color(0xFFFFFFFF)),),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 100,right: 100),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('../images/helloIMG1.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Color(0x9F000000), BlendMode.darken),
                        ),
                      ),
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "營隊活動",
                            style: TextStyle(fontSize: 80, color: Color(0xFFfafafa)),),
                          SizedBox(height: 50,),
                          Text(
                            "我們每學期將規畫並舉辦數個與程式設計、資訊科學領域相關的營隊活動，營隊內容囊括各類主題，不論是零基礎的程式設計初學者，或是有一定基礎的同學，都能透過參加我們的營隊，獲得一系列的技能和知識，並且在自我價值和創造力方面得到增強，而更好地應對未來的學習和工作挑戰。",
                            style: TextStyle(fontSize: 20, color: Color(0xFFfafafa)),),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 100,right: 100),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('../images/Wong1.png'),
                          colorFilter: ColorFilter.mode(
                              Color(0x9F000000), BlendMode.darken),
                          repeat: ImageRepeat.repeat,
                        ),
                      ),
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "線上課程",
                            style: TextStyle(fontSize: 80, color: Color(0xFFfafafa)),),
                          SizedBox(height: 50,),
                          Text(
                            "我們每學期將規畫並舉辦數個與程式設計、資訊科學領域相關的營隊活動，營隊內容囊括各類主題，不論是零基礎的程式設計初學者，或是有一定基礎的同學，都能透過參加我們的營隊，獲得一系列的技能和知識，並且在自我價值和創造力方面得到增強，而更好地應對未來的學習和工作挑戰。",
                            style: TextStyle(fontSize: 20, color: Color(0xFFfafafa)),),
                          SizedBox(height: 50,),
                          ShakeWidget(
                            duration: Duration(milliseconds: 500),
                            shakeConstant: ShakeDefaultConstant2(),
                            autoPlay: true,
                            // enableWebMouseHover: enableLoginBT ? false : true,
                            child: InkWell(
                                child: Text('點此瀏覽課程',style: TextStyle(fontSize: 20, color: Color(0xFFff4060),fontWeight: FontWeight.bold),),
                                onTap: () => launchUrl(Uri(
                                    scheme: 'https',
                                    host: 'www.youtube.com',
                                    path: '/watch',
                                    queryParameters: {'v': 'dQw4w9WgXcQ'}
                                )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 100,right: 100),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('../images/helloIMG2.png'),
                          colorFilter: ColorFilter.mode(
                              Color(0x9F000000), BlendMode.darken),
                          fit: BoxFit.cover,
                          // repeat: ImageRepeat.repeatX,
                        ),
                      ),
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "教學文章",
                            style: TextStyle(fontSize: 80, color: Color(0xFFfafafa)),),
                          SizedBox(height: 50,),
                          Text(
                            "我們每學期將規畫並舉辦數個與程式設計、資訊科學領域相關的營隊活動，營隊內容囊括各類主題，不論是零基礎的程式設計初學者，或是有一定基礎的同學，都能透過參加我們的營隊，獲得一系列的技能和知識，並且在自我價值和創造力方面得到增強，而更好地應對未來的學習和工作挑戰。",
                            style: TextStyle(fontSize: 20, color: Color(0xFFfafafa)),),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 100,right: 100),
                      // decoration: const BoxDecoration(
                      //   image: DecorationImage(
                      //     image: AssetImage('../images/helloIMG2.png'),
                      //     colorFilter: ColorFilter.mode(
                      //         Color(0x9F000000), BlendMode.darken),
                      //     fit: BoxFit.cover,
                      //     // repeat: ImageRepeat.repeatX,
                      //   ),
                      // ),
                      color: Color(0xFFFFFFFF),
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: Column(
                          children: [
                            Text(
                              "學員反饋",
                              style: TextStyle(fontSize: 64, color: Color(0xFF000000)),),
                            SizedBox(height: 50,),
                            Wrap(
                              spacing: 10.0,
                              runSpacing: 10.0,
                              children: [
                                for(OpinonCard i in OPC) i,
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Footer(),
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
