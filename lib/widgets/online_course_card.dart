import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OnlineCourseCard extends StatefulWidget {
  const OnlineCourseCard({
    super.key,
    this.width = 350,
    required this.imageUrl,
    required this.courseName,
    this.onTap,
  });

  final double width;
  final String imageUrl;
  final String courseName;
  final void Function()? onTap;

  @override
  State<OnlineCourseCard> createState() => _OnlineCourseCardState();
}

class _OnlineCourseCardState extends State<OnlineCourseCard> {
  Uint8List? _imageByte;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // final scale = MediaQuery.of(context).size.width / 1440.0;
    if (_imageByte == null && widget.imageUrl != "") {
      http
          .get(Uri.parse(widget.imageUrl))
          .timeout(const Duration(seconds: 5))
          .then((response) => setState(() => _imageByte = response.bodyBytes))
          .catchError((_) => setState(() => _imageByte = null));
    }

    return Container(
      width: widget.width,
      // height: 300,
      decoration: BoxDecoration(
        color: const Color(0xffd6e4ff),
        borderRadius: BorderRadius.circular(30),
      ),
      child: GestureDetector(
        onTap: () {
          if (widget.onTap != null) widget.onTap!.call();
        },
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor:
              _isHovered ? SystemMouseCursors.click : SystemMouseCursors.basic,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: widget.width,
                height: 200,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Builder(
                    builder: (context) {
                      if (_imageByte != null) {
                        return Image.memory(
                          _imageByte!,
                          fit: BoxFit.cover,
                        );
                      }
                      return const Placeholder();
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(30.0, 20.0, 0.0, 20.0),
                  child: SelectionContainer.disabled(
                    child: Text(
                      widget.courseName,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        height: 29.0 / 24.0,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
