import 'package:flutter/material.dart';
import 'package:service_learning_website/pages/fav_page.dart';
import 'package:service_learning_website/pages/login_page.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/test/window_size.dart';
import 'package:service_learning_website/widgets/bottom.dart';
import 'package:service_learning_website/widgets/my_progress_bar.dart';
import 'package:service_learning_website/widgets/online_course_card.dart';
import 'package:service_learning_website/widgets/side_menu.dart';
import 'package:service_learning_website/widgets/user_icon/user_icon.dart';
import 'package:service_learning_website/widgets/schedule_column.dart';
import 'package:service_learning_website/widgets/my_album.dart';
import 'package:service_learning_website/widgets/question_column.dart';
import 'package:service_learning_website/widgets/asking_question_form.dart';
import 'package:service_learning_website/widgets/question_menu.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageSkeleton(
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              UserIcon(size: 32),
            ],
          ),
          const SideMenu(
              width: 260,
              items: ["營隊管理", "文章管理", "課程管理", "使用者管理", "常見問題", "表單回覆"]),
          const SizedBox(height: 20),
          ScheduleColumn(
            dateTime: DateTime.now(),
            morning: "早上早上早上",
            afternoon: "下午下午下午",
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          const Question_column(),
          const SizedBox(height: 20),
          const Question_menu(),
          const SizedBox(height: 20),
          const SideMenu(
              width: 260,
              items: ["分類一", "分類二", "分類三", "分類四"]),   
          const SizedBox(height: 20), 
          const Asking_question_form(),
          const SizedBox(height: 20),
          const MyProgressBar(all: 10, finished: 8),
          const Bottom(
            txt: '進行測驗',
            nextPage: LoginPage(),
          ),
          const Bottom(
            txt: '我有問題',
            nextPage: FavPage(),
          ),
          const OnlineCourseCard(
            imageUrl: "assets/images/google.png",
            courseName: "123",
          ),
          const MyAlbum(
            width: 128,
            height: 128,
            imageUrl: "assets/images/20230504_184123.jpg",
          ),
        ],
      ),
      bottomSheet: const WindowSize(),
    );
  }

  static const List<String> question = [
    '1. 我們現在在學的程式語言是以下何者？',
    '2. 如何print出Hello World？'
  ];

  static const List<String> answer = ['', 'print("Hello World")'];

  static const List<String> options = [
    'Python',
    'C++',
    'Java',
    'Dart',
    'HTML',
    'JavaScript',
    'CSS',
    'C#'
  ];

  static const String mdContent = """
  # Markdown 測試

  ## 服學規劃

  |日期|項目|說明|
  |---|---|---|
  |04/18（二）|期中提案|- 需完成營隊所有內容，包含簡報、講義、營隊當天工作分配、報名表單、經費規劃，並於服學課程中報告與展示</br>- 網課與網站展示目前進度與成果，並報告詳細進度規劃|
  |04/25（二）|AI, PY2 驗課|- 助教會再指定特定章節請講師演示</br>- 其他組休息；同時段另一組提供建議|
  |05/02（二）|PY1, PY3 驗課|- 助教會再指定特定章節請講師演示</br>- 其他組休息；同時段另一組提供建議|
  |05/09（二）|PY1, PY2, PY3 上機操作|- 實際操作營隊使用的電腦教室，熟悉設備</br>- 著重於程式碼實作的部分|
  |05/13, 14（六、日）|PY1, PY2, PY3 營期第一週||
  |05/16（二）|PY1, PY2, PY3 第一週檢討||
  |05/20, 21（六、日）|PY1, PY2, PY3 營期第二週||
  |05/23（二）|AI 二驗、行前會||
  |05/27, 28（六、日）|AI 營期|去台中|
  - 網課與網站組需每週另外約時間（或使用服學課程時間）與助教討論、確認進度


  ## 檔案結構

  - Linux 檔案結構是一個 tree，這個 tree 的 root 稱為 **根目錄 (/)**
    ![](https://i.imgur.com/vyGJeTL.png)
  - 在 Linux 上可以有很多使用者，包含 **一般使用者** 與 **超級管理員 (root)**
  - 每個檔案都有一個擁有者、所屬群組，也可以個別設定擁有者、所屬群組、其他人的讀取、修改、執行權限
  - 使用者可以有一個 **家目錄 (~)**，是打開終端機預設的初始位置，一般使用者的家目錄通常為 **/home/<使用者名稱>**，超級管理員的家目錄通常是 **/root**
  - 表達檔案或資料夾位置可使用 **絕對路徑** 或 **相對路徑**
    - 絕對路徑以 **根目錄 (/)** 出發，例如：`/var/www`、`/home/squid/Documents`
    - 相對路徑會由參考目錄出發，常見的參考目錄有：
      - 當前目錄 (.)
      - 上一層目錄 (..)
      - 家目錄 (~)
      - 上一次處在的目錄 (-)
    - 例如：`./Desktop`、`~/Documents/Programming`
  - 在 Linux 中，以 **點 (.)** 開頭的檔案或目錄為隱藏檔案，例如：.vim、.bashrc，這些檔案是存在的，但 GUI 介面中看不到
  - Windows 上直接以副檔名判別檔案類型，像是 txt 是文字檔、exe 是執行檔，更改附檔名會造成檔案無法開啟；但在 Linux 上，副檔名只是給使用者判別用的，他們本質上就是文字檔或二進制檔，像是一個 Python 檔，就算不打副檔名，一樣能透過 `python` 指令執行。
  - **星號 ( * )** 為萬用字元，表示任意長度的任意字元，例如：
    - *.cpp 表示所有 cpp 檔
    - ./* 表示當前目錄下所有檔案

  
  ```cpp
  #include <iostream>
  using namespace std;
  int main() {
    cout << "hello!" << endl;
    return 0;
  }
  ```
  """;
}
