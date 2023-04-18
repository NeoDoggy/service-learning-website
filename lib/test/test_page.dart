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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                UserIcon(size: 32),
              ],
            ),
            MyMarkdown(mdContent),
            const WindowSize(),
          ],
        ),
      ),
    );
  }



  final String mdContent = """
  # Linux 筆記

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