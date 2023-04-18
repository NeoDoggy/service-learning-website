import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFFffffff),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 56,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerTheme: const DividerThemeData(color: Colors.transparent),
                  ),
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            padding: EdgeInsets.only(bottom: 4),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.menu),color: Color(0xFF858585),),
                        SizedBox(width: 20),
                        Icon(Icons.logo_dev,color: Color(0xFF474747),),
                        SizedBox(width: 3),
                        Text(
                          'ServiceSite_LOGO',
                          style: TextStyle(
                            color: Color(0xFF474747),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  children: [
                    Divider(color: Color(0xFF787878),),
                    Card(
                      color: Color(0xFFf5f5f5),
                      child: ListTile(
                        leading: Icon(Icons.home,color: Color(0xFF1f1f1f),),
                        title: const Text(
                          'MainPage',
                          style: TextStyle(color: Color(0xFF1f1f1f)),
                        ),
                        // trailing: Icon(Icons.more_vert,color: Color(0xFFFFFFFF)),
                        onTap: () {
                          context.push('/');
                          //Navigator.pop(context);
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xFFf5f5f5),
                      child: ListTile(
                        leading: Icon(Icons.favorite,color: Color(0xFF1f1f1f),),
                        title: const Text(
                          'FavPage',
                          style: TextStyle(color: Color(0xFF1f1f1f)),
                        ),
                        // trailing: Icon(Icons.more_vert,color: Color(0xFFFFFFFF)),
                        onTap: () {
                          context.push('/favorites');
                          // Navigator.of(context).pushNamed('/favorites');
                          // Navigator.of(context).pushReplacement(CustomPageRoute(builder: (BuildContext context){return FavPage();}));
                          //Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
