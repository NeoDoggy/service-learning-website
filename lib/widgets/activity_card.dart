import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:service_learning_website/modules/backend/activity/activity_calendar_data.dart';

class ActivityCard extends StatefulWidget {
  const ActivityCard({
    super.key,
    this.width = 350,
    required this.title,
    required this.deadline,
    required this.calendar,
    required this.place,
    required this.audience,
    required this.imageUrl,
    this.onTap,
  });

  final double width;
  final DateTime deadline;
  final List<ActivityCalendarData> calendar;
  final String title;
  final String place;
  final String audience;
  final String imageUrl;
  final void Function()? onTap;

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  Uint8List? _imageBytes;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    if (_imageBytes == null && widget.imageUrl != "") {
      http
          .get(Uri.parse(widget.imageUrl))
          .timeout(const Duration(seconds: 5))
          .then((value) => setState(() => _imageBytes = value.bodyBytes))
          .catchError((_) => setState(() => _imageBytes = null));
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
                      if (_imageBytes != null) {
                        return Image.memory(
                          _imageBytes!,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title,
                            style: const TextStyle(
                              fontSize: 24.0,
                              height: 48 / 24,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/calender.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var str in widget.calendar.map(
                                    (e) => DateFormat("MM/dd - E").format(e.date)))
                                  Text(str,
                                      style: const TextStyle(fontSize: 20))
                              ],
                            ),
                            // Text(
                            //     widget.calendar
                            //         .map((e) =>
                            //             DateFormat("MM/dd").format(e.date))
                            //         .join("、"),
                            //     style: const TextStyle(fontSize: 20)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/locationmark.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(widget.place,
                                style: const TextStyle(fontSize: 20.0)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/images/object.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(widget.audience,
                                style: const TextStyle(fontSize: 20.0)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // return Container(
    //   width: 350.0,
    //   height: 469.0,
    //   decoration: BoxDecoration(
    //     color: const Color(0xFFD6E4FF),
    //     borderRadius: BorderRadius.circular(30),
    //   ),
    //   child: Stack(
    //     children: [
    //       Positioned(
    //         child: Container(
    //           width: 350.0,
    //           height: 200.0,
    //           decoration: BoxDecoration(
    //             borderRadius: const BorderRadius.only(
    //               topLeft: Radius.circular(30),
    //               topRight: Radius.circular(30),
    //             ),
    //             image: _imageBytes != null
    //                 ? DecorationImage(
    //                     image: MemoryImage(_imageBytes!),
    //                     fit: BoxFit.cover,
    //                   )
    //                 : null,
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         left: 20.0,
    //         top: 20.84,
    //         child: Container(
    //           width: 117.0,
    //           height: 32.31,
    //           decoration: BoxDecoration(
    //             color: const Color(0xFF4EAAFA),
    //             borderRadius: BorderRadius.circular(30),
    //           ),
    //           child: Center(
    //             child: Text(
    //               '${DateFormat("MM/dd").format(widget.deadline)} 截止',
    //               style: const TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 18,
    //                 fontWeight: FontWeight.normal,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //           left: 30.0,
    //           top: 230.0,
    //           child: Center(
    //             child: Text(
    //               widget.title,
    //               style: const TextStyle(
    //                 fontSize: 24,
    //                 color: Colors.black,
    //               ),
    //             ),
    //           )),
    //       const Positioned(
    //           left: 100.0,
    //           top: 284.0,
    //           child: Center(
    //             child: Text(
    //               '4/8起，共 6 堂課',
    //               style: TextStyle(
    //                 fontSize: 20,
    //                 color: Colors.black,
    //               ),
    //             ),
    //           )),
    //       Positioned(
    //           left: 100.0,
    //           top: 332.0,
    //           child: Center(
    //             child: Text(
    //               widget.place,
    //               style: const TextStyle(
    //                 fontSize: 20,
    //                 color: Colors.black,
    //               ),
    //             ),
    //           )),
    //       Positioned(
    //           left: 100.0,
    //           top: 404.0,
    //           child: Center(
    //             child: Text(
    //               widget.audience,
    //               style: const TextStyle(
    //                 fontSize: 20,
    //                 color: Colors.black,
    //               ),
    //             ),
    //           )),
    //       Positioned(
    //         left: 30.0,
    //         top: 279.0,
    //         child: Container(
    //           width: 40.0,
    //           height: 40.0,
    //           decoration: const BoxDecoration(
    //             shape: BoxShape.circle,
    //             image: DecorationImage(
    //               image: AssetImage('assets/images/calender.png'),
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         left: 30.0,
    //         top: 339.0,
    //         child: Container(
    //           width: 40.0,
    //           height: 40.0,
    //           decoration: const BoxDecoration(
    //             image: DecorationImage(
    //               image: AssetImage('assets/images/locationmark.png'),
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         left: 30.0,
    //         top: 399.0,
    //         child: Container(
    //           width: 40.0,
    //           height: 40.0,
    //           decoration: const BoxDecoration(
    //             image: DecorationImage(
    //               image: AssetImage('assets/images/object.png'),
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
