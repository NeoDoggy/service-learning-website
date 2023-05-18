import 'package:flutter/material.dart';
import 'package:service_learning_website/widgets/user_icon/user_icon.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("ServiceSite_LOGO"),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text("關於我們"),
              Text("營隊活動"),
              Text("教學文章"),
              Text("線上課程"),
              Text("常見 Q&A"),
              UserIcon(size: 50),
            ],
          ),
        ],
      ),
    );
  }
}
