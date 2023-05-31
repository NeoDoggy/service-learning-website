import 'package:flutter/material.dart';

class ActicvityEnrollingSuccessful extends StatelessWidget {
  const ActicvityEnrollingSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 400),
      padding: const EdgeInsets.all(100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: const Column(children: [
        Center(
            child: Text("報名資訊",
                style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold))),
        SizedBox(height: 50),
        Text("報名成功！確認信件已寄送至您的信箱，我們將於報名截止經過審核後以 Email 通知您錄取結果。"),
      ]),
    );
  }
}
