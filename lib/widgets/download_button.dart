import 'package:flutter/material.dart';
import 'package:service_learning_website/modules/url_downloader.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
    required this.url,
    required this.filename,
  });

  final String url;
  final String filename;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      constraints: const BoxConstraints(maxWidth: 880),
      child: ElevatedButton(
        onPressed: () => UrlDownloader.download(url, filename),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90.0),
                  side:
                      const BorderSide(color: Color(0xff0e6ba8), width: 2.0))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 15),
            const Icon(Icons.insert_link, size: 64),
            const SizedBox(width: 15),
            SelectionContainer.disabled(
                child: Text(filename,
                    style: const TextStyle(fontSize: 32, height: 0.5))),
          ],
        ),
      ),
    );
  }
}
