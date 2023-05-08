import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  ArticleCard({
    super.key,
    required this.Title,
    required this.Link,
    required this.Content,
    required this.Height,
    required this.Width,
    required this.Taglist,
  });

  String Title;
  String Link;
  String Content;
  double Height;
  double Width;
  List<String> Taglist = [];

  void set_size(double height,double width){
      this.Height = height;
      this.Width = width;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

        // Navigator.of(context).pushReplacement(CustomPageRoute(builder: (BuildContext context){return ArticlesPage();}));
      
      },
      child: Container(
        height: Height,
        width: Width,
        child: Card(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(15)) ),
          color: Color(0xFFfafafa),
          elevation: 0,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: Width,
                  height: Height*0.6,
                  child: Card(elevation: 0,color: Color.fromARGB(243, 255, 255, 255))
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 25,bottom: 25,right: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          Title,
                          style: TextStyle(color: Color(0xFF1f1f1f),fontSize: 30,fontWeight: FontWeight.bold),
                          softWrap: true,
                          overflow: TextOverflow.clip,
                          ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: Width,
                        child: Text(Content)
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          for(String i in Taglist)
                            Text("#"+i)
                          ],
                        ),
                    )
                    
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