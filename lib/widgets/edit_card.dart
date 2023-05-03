import 'package:flutter/material.dart';

class EditCard extends StatelessWidget {
  const EditCard({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 1500,
      width: 600,
      child: Card(
        // margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        color: const Color(0xFFffffff),
        elevation: 0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:8),
              child: Text(
                '編輯：$name',
                style: const TextStyle(
                    color: Color(0xFF474747),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 25, bottom: 25,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("課程圖示",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF474747)),),
                          SizedBox(height: 10,),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Card(
                              elevation: 0,
                              color: Color(0xFFf5f5f5),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("課程横幅",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF474747)),),
                          SizedBox(height: 10,),
                          SizedBox(
                            width: 300,
                            height: 100,
                            child: Card(
                              elevation: 0,
                              color: Color(0xFFf5f5f5),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  const Text("課程名稱",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF474747)),),
                  const SizedBox(height: 10,),
                  TextFormField(
                    cursorColor: const Color(0xFF474747),
                    style: const TextStyle(color: Color(0xFF474747)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFf5f5f5),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0,color: Colors.transparent)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1,color: Color(0xFF474747))
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0,color: Color(0xFFff4060))
                      ),
                      //labelText: '課程名稱',
                      labelStyle: TextStyle(color: Color(0xFF474747),fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text("課程敘述",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF474747)),),
                  const SizedBox(height: 10,),
                  TextFormField(
                    cursorColor: const Color(0xFF474747),
                    style: const TextStyle(color: Color(0xFF474747)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFf5f5f5),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0,color: Colors.transparent)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1,color: Color(0xFF474747))
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0,color: Color(0xFFff4060))
                      ),
                      //labelText: '課程名稱',
                      labelStyle: TextStyle(color: Color(0xFF474747),fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text("地點",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF474747)),),
                  const SizedBox(height: 10,),
                  TextFormField(
                    cursorColor: const Color(0xFF474747),
                    style: const TextStyle(color: Color(0xFF474747)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFf5f5f5),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0,color: Colors.transparent)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1,color: Color(0xFF474747))
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0,color: Color(0xFFff4060))
                      ),
                      //labelText: '課程名稱',
                      labelStyle: TextStyle(color: Color(0xFF474747),fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            splashFactory: NoSplash.splashFactory,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            backgroundColor: const Color(0xFF00ba7c),
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(10),
                          ),
                          onPressed: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(5),
                            child: Text("儲存"),
                          )),
                      const SizedBox(width: 10,),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            splashFactory: NoSplash.splashFactory,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            backgroundColor: const Color(0xFFff4060),
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(10),
                          ),
                          onPressed: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(5),
                            child: Text("刪除"),
                          )),
                      const SizedBox(width: 10,),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            splashFactory: NoSplash.splashFactory,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            backgroundColor: const Color(0xFFf5f5f5),
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(10),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(5),
                            child: Text("取消",style: TextStyle(color: Color(0xFF474747)),),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
