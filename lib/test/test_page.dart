import 'package:flutter/material.dart';
import 'package:service_learning_website/test/window_size.dart';
import 'package:service_learning_website/widgets/my_markdown.dart';
import 'package:service_learning_website/widgets/user_icon.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const WindowSize(),
            const UserIcon(size: 32),
            MyMarkdown(mdContent),
          ],
        ),
      ),
    );
  }



  final String mdContent = """
  # 3/29 交通

  - 住宿地點 <-> 櫻島渡輪鹿兒島開航處
      - 鹿兒島中央站 ==`坐公車(市16)`== 水族館前
          - 約 25 分鐘
          - ￥ 190
      - 鹿兒島中央站 ==坐鹿兒島市電2系統== 水族館口
          - 約 25 分鐘 (內含走路 10 分鐘)
          - ￥ 170

  - 櫻島渡輪鹿兒島開航處 <-> 櫻島港渡輪碼頭
    [https://www.city.kagoshima.lg.jp/sakurajima-ferry/koro-jikoku/timetable.html](https://www.city.kagoshima.lg.jp/sakurajima-ferry/koro-jikoku/timetable.html)
    ![](https://i.imgur.com/RJMgWJd.png)
      - 約 20 分鐘
      - ￥ 200
  
  ```
  #include <iostream>
  using namespace std;
  int main() {
    cout << "hello!" << endl;
    return 0;
  }
  ```
  
  """;
}