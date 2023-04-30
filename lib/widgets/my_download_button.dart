import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class MyDownloadButton extends StatelessWidget {
  const MyDownloadButton({super.key});

  Future<void> downloadAndSaveFile(String url, String fileName) async {
    var bytes = await http.readBytes(Uri.parse(url));
    var dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      constraints: const BoxConstraints(maxWidth: 800),
      child: ElevatedButton(
        onPressed: () async {
          var fileUrl = 'https://example.com/file.pdf';
          await downloadAndSaveFile(fileUrl, 'myfile.pdf');
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          // fixedSize: MaterialStateProperty.all<Size>(
          //   const Size(880, 70),
          // ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90.0),
                  side:
                      const BorderSide(color: Color(0xff0e6ba8), width: 2.0))),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 15),
            Icon(Icons.insert_link, size: 64),
            SizedBox(width: 15),
            Text('下載', style: TextStyle(fontSize: 32, height: 0.5)),
          ],
        ),
      ),
    );
  }
}
