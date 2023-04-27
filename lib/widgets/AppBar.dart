import 'package:flutter/material.dart';
import 'CustomPageRoute.dart';
import '../Pages/FavPage.dart';
import '../Pages/LoginPage.dart';
import 'package:go_router/go_router.dart';

class AppBar_G extends StatelessWidget {
  AppBar_G({
    super.key,
    // required this.bottom,
  });


  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconThemeData(color: Color(0xFF858585),),
      title: Row(
        children: [
          Icon(Icons.logo_dev,color: Color(0xFF474747),),
          SizedBox(width: 3),
          Text('ServiceSite_LOGO',style: TextStyle(color: Color(0xFF474747),),),
        ],
      ),
      backgroundColor: Color(0xFFffffff),
      pinned: false,
      elevation: 0,
      //floating: true,
      //forceElevated: innerBoxIsScrolled,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Builder(builder: (BuildContext context){
                return InkWell(
                  hoverColor: Colors.transparent,
                  onTap: (){
                    context.push('/');
                  },
                  child: Text("關於我們",style: TextStyle(color: Color(0xFF474747),fontSize: 16),),
                );
              }),
              SizedBox(width: 50,),
              Builder(builder: (BuildContext context){
                return InkWell(
                  hoverColor: Colors.transparent,
                  onTap: (){
                    context.push('/');
                  },
                  child: Text("營隊活動",style: TextStyle(color: Color(0xFF474747),fontSize: 16),),
                );
              }),
              SizedBox(width: 50,),
              Builder(builder: (BuildContext context){
                return InkWell(
                  hoverColor: Colors.transparent,
                  onTap: (){
                    context.push('/');
                  },
                  child: Text("教學文章",style: TextStyle(color: Color(0xFF474747),fontSize: 16),),
                );
              }),
              SizedBox(width: 50,),
              Builder(builder: (BuildContext context){
                return InkWell(
                  hoverColor: Colors.transparent,
                  onTap: (){
                    context.push('/');
                  },
                  child: Text("線上課程",style: TextStyle(color: Color(0xFF474747),fontSize: 16),),
                );
              }),
              SizedBox(width: 50,),
              Builder(builder: (BuildContext context){
                return InkWell(
                  hoverColor: Colors.transparent,
                  onTap: (){
                    context.push('/');
                  },
                  child: Text("Q&A",style: TextStyle(color: Color(0xFF474747),fontSize: 16),),
                );
              }),
              SizedBox(width: MediaQuery.of(context).size.width/2.5,),
              // Builder(builder: (BuildContext context) {
              //   return IconButton(
              //     onPressed: () {
              //       context.push('/favorites');
              //     },
              //     tooltip: 'Show Favourites',
              //     icon: Icon(Icons.favorite),color: Color(0xFF858585),);
              // }),
              // SizedBox(width: 10),
              Builder(builder: (BuildContext context){
                return IconButton(
                  onPressed: (){
                    context.push('/login');
                  },
                  icon: Icon(Icons.account_circle),color: Color(0xFF858585),);
              }),
              SizedBox(width: 10),
              // Icon(Icons.more_vert),
            ],
          ),
        ),
      ],
    );
  }
}