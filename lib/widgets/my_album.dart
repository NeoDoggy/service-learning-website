import 'dart:typed_data';

import 'package:flutter/material.dart';

class MyAlbum extends StatefulWidget {
  const MyAlbum({
    super.key,
    this.width,
    this.height,
    // required this.imageBytes,
    required this.imageUrl,
  });

  final double? width;
  final double? height;
  // final Uint8List imageBytes;
  final String imageUrl;

  @override
  State<MyAlbum> createState() => _MyAlbumState();
}

class _MyAlbumState extends State<MyAlbum> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      // child: Image.memory(widget.imageBytes),
      child: Image.asset(widget.imageUrl, fit: BoxFit.cover),
    );
  }
}
