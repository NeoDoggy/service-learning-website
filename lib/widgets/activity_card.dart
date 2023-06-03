import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ActivityCard extends StatefulWidget {
  const ActivityCard({
    super.key,
    required this.title,
    required this.deadline,
    required this.place,
    required this.audience,
    required this.imageUrl,
  });

  final DateTime deadline;
  final String title;
  final String place;
  final String audience;
  final String imageUrl;

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  Uint8List? _imageBytes;

  @override
  Widget build(BuildContext context) {
    if (_imageBytes == null) {
      http
          .get(Uri.parse(widget.imageUrl))
          .timeout(const Duration(seconds: 5))
          .then((value) => setState(() => _imageBytes = value.bodyBytes))
          .catchError((_) => setState(() => _imageBytes = null));
    }

    return Container(
      width: 350.0,
      height: 469.0,
      decoration: BoxDecoration(
        color: const Color(0xFFD6E4FF),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          Positioned(
            child: Container(
              width: 350.0,
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                image: _imageBytes != null
                    ? DecorationImage(
                        image: MemoryImage(_imageBytes!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
          ),
          Positioned(
            left: 20.0,
            top: 20.84,
            child: Container(
              width: 117.0,
              height: 32.31,
              decoration: BoxDecoration(
                color: const Color(0xFF4EAAFA),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  '${DateFormat("MM/dd").format(widget.deadline)} 截止',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: 30.0,
              top: 230.0,
              child: Center(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              )),
          const Positioned(
              left: 100.0,
              top: 284.0,
              child: Center(
                child: Text(
                  '4/8起，共 6 堂課',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              )),
          Positioned(
              left: 100.0,
              top: 332.0,
              child: Center(
                child: Text(
                  widget.place,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              )),
          Positioned(
              left: 100.0,
              top: 404.0,
              child: Center(
                child: Text(
                  widget.audience,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              )),
          Positioned(
            left: 30.0,
            top: 279.0,
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/calender.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 30.0,
            top: 339.0,
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/locationmark.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 30.0,
            top: 399.0,
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/object.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
