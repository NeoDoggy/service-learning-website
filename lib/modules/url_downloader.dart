// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart';

abstract class UrlDownloader {
  static Future<bool> download(String url, String filename) async {
    try {
      final response =
          await get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      final content = base64Encode(response.bodyBytes);
      final anchor = AnchorElement(
          href:
              "data:application/octet-stream;charset=utf-16le;base64,$content");
      anchor.download = filename;
      anchor.click();
    } catch (e) {
      return false;
    }
    return true;
  }
}
