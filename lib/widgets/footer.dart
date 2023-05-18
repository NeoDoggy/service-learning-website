import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF102542),
      child: Container(
        padding: const EdgeInsets.only(top: 30, bottom: 30),
        child: const Center(
            child: SelectableText(
          "單位：國立中央大學資訊工程學系\n地址：(320317) 桃園市中壢區中大路300號\n聯絡電話：03-422-7151\nEmail：ncu4500@ncu.edu.tw",
          style: TextStyle(color: Color(0xFFFFFFFF)),
        )),
      ),
    );
  }
}
