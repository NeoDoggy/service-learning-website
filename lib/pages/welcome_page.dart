import 'package:flutter/material.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/widgets/opinion_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<OpinonCard> opc = [
      const OpinonCard(said: "真是一個好平台"),
      const OpinonCard(said: "給你滿滿的大平台"),
      const OpinonCard(said: "這平台真棒"),
      const OpinonCard(said: "哈哈我好喜憨"),
    ];

    final List<String> images = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];

    return PageSkeleton(
      isPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('assets/images/helloIMG3.png'),
            //     colorFilter: ColorFilter.mode(
            //         Color(0x9F000000), BlendMode.darken),
            //     repeat: ImageRepeat.repeat,
            //   ),
            // ),
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height - 56,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 794 * 120,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height / 794 * 100,
                        right: MediaQuery.of(context).size.height / 794 * 100),
                    height: MediaQuery.of(context).size.height / 794 * 450,
                    width: MediaQuery.of(context).size.height / 794 * 1000,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x30474747),
                          blurRadius: 100.0,
                        ),
                      ],
                    ),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: const Color(0xFF1F6AFB),
                      elevation: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "中央資訊教育平台",
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width /
                                    1474 *
                                    75,
                                color: const Color(0xFFFFFFFF)),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height / 794 * 75,
                          ),
                          Text(
                            "NCU Computer Science Tutorial Platform",
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width /
                                    1474 *
                                    24,
                                color: const Color(0xFFFFFFFF)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 794 * 120,
                ),
                Icon(
                  Icons.expand_more_outlined,
                  color: const Color(0xFF000000),
                  size: MediaQuery.of(context).size.height / 794 * 32,
                )
              ],
            ),
          ),
          Container(
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('assets/images/Wong2.png'),
            //     colorFilter: ColorFilter.mode(
            //         Color(0x9F000000), BlendMode.darken),
            //     repeat: ImageRepeat.repeat,
            //   ),
            // ),
            color: const Color(0xFFF2F4FF),
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: Container(
              padding: const EdgeInsets.only(left: 150, right: 150, top: 50),
              height: 450,
              width: 1000,
              child: Column(
                children: [
                  const Text(
                    "關於我們",
                    style: TextStyle(fontSize: 64, color: Color(0xFF000000)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "「中央資訊教育平台」是由中央大學資工系同學所架設的網頁平台，以推廣程式設計、資訊科學素養為目標，讓有興趣接觸這塊領域的同學，能透過本平台報名營隊活動或是加入線上課程，探索學習相關知識，我們也歡迎學校或其他單位與我們合作！",
                    style: TextStyle(fontSize: 24, color: Color(0xFF000000)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            color: const Color(0xFF0A2472),
                            elevation: 0,
                            child: SizedBox(
                              width: 500,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(60),
                                child: Center(
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.diversity_3_outlined,
                                        color: Color(0xFFFFFFFF),
                                        size: 75,
                                      ),
                                      SizedBox(
                                        width: 60,
                                      ),
                                      Text(
                                        "營隊活動",
                                        style: TextStyle(
                                            fontSize: 36,
                                            color: Color(0xFFFFFFFF)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            color: const Color(0xFF0A2472),
                            elevation: 0,
                            child: SizedBox(
                              width: 500,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(60),
                                child: Center(
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.help_outline_outlined,
                                        color: Color(0xFFFFFFFF),
                                        size: 75,
                                      ),
                                      SizedBox(
                                        width: 60,
                                      ),
                                      Text(
                                        "常見問題",
                                        style: TextStyle(
                                            fontSize: 36,
                                            color: Color(0xFFFFFFFF)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            color: const Color(0xFF0A2472),
                            elevation: 0,
                            child: SizedBox(
                              width: 500,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(60),
                                child: Center(
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.data_object_outlined,
                                        color: Color(0xFFFFFFFF),
                                        size: 75,
                                      ),
                                      SizedBox(
                                        width: 60,
                                      ),
                                      Text(
                                        "教學文章",
                                        style: TextStyle(
                                            fontSize: 36,
                                            color: Color(0xFFFFFFFF)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            color: const Color(0xFF0A2472),
                            elevation: 0,
                            child: SizedBox(
                              width: 500,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(60),
                                child: Center(
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.connected_tv_outlined,
                                        color: Color(0xFFFFFFFF),
                                        size: 75,
                                      ),
                                      SizedBox(
                                        width: 60,
                                      ),
                                      Text(
                                        "線上課程",
                                        style: TextStyle(
                                            fontSize: 36,
                                            color: Color(0xFFFFFFFF)),
                                      ),
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
            padding: const EdgeInsets.only(left: 150, right: 150),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/helloIMG1.png'),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Color(0x9F000000), BlendMode.darken),
              ),
            ),
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "營隊活動",
                  style: TextStyle(fontSize: 80, color: Color(0xFFfafafa)),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "我們每學期將規畫並舉辦數個與程式設計、資訊科學領域相關的營隊活動，營隊內容囊括各類主題，不論是零基礎的程式設計初學者，或是有一定基礎的同學，都能透過參加我們的營隊，獲得一系列的技能和知識，並且在自我價值和創造力方面得到增強，而更好地應對未來的學習和工作挑戰。",
                  style: TextStyle(fontSize: 20, color: Color(0xFFfafafa)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 150, right: 150),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Wong1.png'),
                colorFilter:
                    ColorFilter.mode(Color(0x9F000000), BlendMode.darken),
                repeat: ImageRepeat.repeat,
              ),
            ),
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "線上課程",
                  style: TextStyle(fontSize: 80, color: Color(0xFFfafafa)),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "我們每學期將規畫並舉辦數個與程式設計、資訊科學領域相關的營隊活動，營隊內容囊括各類主題，不論是零基礎的程式設計初學者，或是有一定基礎的同學，都能透過參加我們的營隊，獲得一系列的技能和知識，並且在自我價值和創造力方面得到增強，而更好地應對未來的學習和工作挑戰。",
                  style: TextStyle(fontSize: 20, color: Color(0xFFfafafa)),
                ),
                const SizedBox(
                  height: 50,
                ),
                ShakeWidget(
                  duration: const Duration(milliseconds: 500),
                  shakeConstant: ShakeDefaultConstant2(),
                  autoPlay: true,
                  // enableWebMouseHover: enableLoginBT ? false : true,
                  child: InkWell(
                    child: const Text(
                      '點此瀏覽課程',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFff4060),
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () => launchUrl(Uri(
                      scheme: 'https',
                      host: 'i.imgur.com', //https://i.imgur.com/nnyfmPT.png
                      path:
                          '/nnyfmPT\.png', /*queryParameters: {'v': 'dQw4w9WgXcQ'}*/
                    )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 150, right: 150),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/helloIMG2.png'),
                colorFilter:
                    ColorFilter.mode(Color(0x9F000000), BlendMode.darken),
                fit: BoxFit.cover,
                // repeat: ImageRepeat.repeatX,
              ),
            ),
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "教學文章",
                  style: TextStyle(fontSize: 80, color: Color(0xFFfafafa)),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "我們每學期將規畫並舉辦數個與程式設計、資訊科學領域相關的營隊活動，營隊內容囊括各類主題，不論是零基礎的程式設計初學者，或是有一定基礎的同學，都能透過參加我們的營隊，獲得一系列的技能和知識，並且在自我價值和創造力方面得到增強，而更好地應對未來的學習和工作挑戰。",
                  style: TextStyle(fontSize: 20, color: Color(0xFFfafafa)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 150, right: 150),
            color: const Color(0xFFf2f4ff),
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(top: 40,left: 50,right: 50),
              child: SizedBox(
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "歷年成果",
                        style: TextStyle(fontSize: 64, color: Color(0xFF000000)),
                      ),
                    ),
                    CarouselSlider(
                      options: CarouselOptions(),
                      items: images
                          .map((item) => Center(
                              child: Image.network(
                                  item,
                                  // fit: BoxFit.scaleDown,
                                  // height: 750,
                                  width: 1000
                              )))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 100, right: 100),
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('assets/images/helloIMG2.png'),
            //     colorFilter: ColorFilter.mode(
            //         Color(0x9F000000), BlendMode.darken),
            //     fit: BoxFit.cover,
            //     // repeat: ImageRepeat.repeatX,
            //   ),
            // ),
            color: const Color(0xFFFFFFFF),
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "學員反饋",
                      style: TextStyle(fontSize: 64, color: Color(0xFF000000)),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [
                          for (OpinonCard i in opc) i,
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/*
                        _ooOoo_
                       o8888888o
                       88" . "88
                       (| -_- |)
                       O\  =  /O
                    ____/`---'\____
                  .'  \\|     |//  `.
                 /  \\|||  :  |||//  \
                /  _||||| -:- |||||_  \
                |   | \\\  -  /'| |   |
                | \_|  `\`---'//  |_/ |
                \  .-\__ `-. -'__/-.  /
              ___`. .'  /--.--\  `. .'___
           ."" '<  `.___\_<|>_/___.' _> \"".
          | | :  `- \`. ;`. _/; .'/ /  .' ; |
          \  \ `-.   \_\_`. _.'_/_/  -' _.' /
===========`-.`___`-.__\ \___  /__.-'_.'_.-'================
                        `=--=-'                    //乖乖

_      `-._     `-.     `.   \      :      /   .'     .-'     _.-'      _
 `--._     `-._    `-.    `.  `.    :    .'  .'    .-'    _.-'     _.--'
      `--._    `-._   `-.   `.  \   :   /  .'   .-'   _.-'    _.--'
`--.__     `--._   `-._  `-.  `. `. : .' .'  .-'  _.-'   _.--'     __.--'
__    `--.__    `--._  `-._ `-. `. \:/ .' .-' _.-'  _.--'    __.--'    __
  `--..__   `--.__   `--._ `-._`-.`_=_'.-'_.-' _.--'   __.--'   __..--'
--..__   `--..__  `--.__  `--._`-q(-_-)p-'_.--'  __.--'  __..--'   __..--
      ``--..__  `--..__ `--.__ `-'_) (_`-' __.--' __..--'  __..--''
...___        ``--..__ `--..__`--/__/  \--'__..--' __..--''        ___...
      ```---...___    ``--..__`_(<_   _/)_'__..--''    ___...---'''
```-----....._____```---...___(__\_\_|_/__)___...---'''_____.....-----'''
 ___   __  ________   _______   _       _   _______    ___   __   _______
|| \\  ||     ||     ||_____))  \\     //  ||_____||  || \\  ||  ||_____||
||  \\_||  ___||___  ||     \\   \\___//   ||     ||  ||  \\_||  ||     ||
*/
