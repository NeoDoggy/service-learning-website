// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, no_logic_in_create_state

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/widgets/schedule_column.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';

class ActivityIntro extends StatefulWidget {
  const ActivityIntro({
    super.key,
    required this.activityId,
  });

  final String activityId;

  @override
  State<ActivityIntro> createState() => _ActivityIntroState();
}

class _ActivityIntroState extends State<ActivityIntro> {
  final _subTitleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  final _contentStyle = TextStyle(fontSize: 16);

  Uint8List? _imageByte;
  bool _loaded = false;
  bool _isParticipant = false;

  @override
  Widget build(BuildContext context) {
    final activitiesProvider = Provider.of<ActivitiesProvider>(context);
    if (!_loaded) {
      _loaded = true;
      activitiesProvider.loadActivity(widget.activityId);
    }
    if (activitiesProvider.activitiesData[widget.activityId] == null) {
      return const Scaffold(body: Center(child: Text("Loading")));
    }

    return PageSkeleton(
      body: Consumer2<AuthProvider, ActivitiesProvider>(
        builder: (context, authProvider, activitiesProvider, child) {
          final userData = authProvider.userData;
          final activityData =
              activitiesProvider.activitiesData[widget.activityId]!;

          _isParticipant =
              activityData.participants[userData?.uid ?? ""] != null;

          if (_imageByte == null && activityData.imageUrl != "") {
            http
                .get(Uri.parse(activityData.imageUrl))
                .timeout(const Duration(seconds: 5))
                .then((response) =>
                    setState(() => _imageByte = response.bodyBytes))
                .catchError((_) => setState(() => _imageByte = null));
          }

          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleTextBox(activityData.title),
                const SizedBox(height: 60),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_imageByte != null)
                      Image.memory(_imageByte!, width: 400),
                    if (_imageByte == null)
                      const SizedBox(width: 400, child: Placeholder()),
                    const SizedBox(width: 100),
                    Flexible(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.description),
                                SizedBox(width: 10),
                                Text("課程介紹", style: _subTitleStyle),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(activityData.description,
                                style: _contentStyle),
                            const SizedBox(height: 40),
                            //
                            Row(
                              children: [
                                Icon(Icons.schedule),
                                SizedBox(width: 10),
                                Text("時間", style: _subTitleStyle),
                              ],
                            ),
                            const SizedBox(height: 20),
                            for (var schedule in activityData.calendar)
                              Text(
                                  "${DateFormat('yyyy/MM/dd').format(schedule.date)} ${DateFormat('HH:mm').format(schedule.begin)}~${DateFormat('HH:mm').format(schedule.end)}",
                                  style: _contentStyle),
                            const SizedBox(height: 40),
                            //
                            Row(
                              children: [
                                Icon(Icons.place),
                                SizedBox(width: 10),
                                Text("地點", style: _subTitleStyle),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(activityData.place, style: _contentStyle),
                            const SizedBox(height: 40),
                            //
                            Row(
                              children: [
                                Icon(Icons.people),
                                SizedBox(width: 10),
                                Text("適合對象", style: _subTitleStyle),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(activityData.audience, style: _contentStyle),
                            const SizedBox(height: 40),
                            //
                            Row(
                              children: [
                                Icon(Icons.attach_money),
                                SizedBox(width: 10),
                                Text("費用", style: _subTitleStyle),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(activityData.fee, style: _contentStyle),
                            const SizedBox(height: 40),
                            //
                            Row(
                              children: [
                                Icon(Icons.calendar_today),
                                SizedBox(width: 10),
                                Text("報名截止", style: _subTitleStyle),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                                DateFormat("yyyy/MM/dd")
                                    .format(activityData.deadline),
                                style: _contentStyle),
                            const SizedBox(height: 40),
                            //
                            Row(
                              children: [
                                Icon(Icons.track_changes),
                                SizedBox(width: 10),
                                Text("課程目標", style: _subTitleStyle),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(activityData.goal, style: _contentStyle),
                            // const SizedBox(height: 40),
                          ]),
                    ),
                  ],
                ),
                const SizedBox(height: 70),
                for (var schedule in activityData.calendar)
                  Column(
                    children: [
                      const SizedBox(height: 30),
                      ScheduleColumn(
                        dateTime: schedule.date,
                        morning: schedule.morning,
                        afternoon: schedule.afternoon,
                      ),
                    ],
                  ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                      onPressed: () async {
                        // if (!authProvider.isAuthed) {
                        //   context.push("/${MyRouter.login}");
                        // } else {
                        //   if (!_isParticipant) {
                        //     await activitiesProvider.addParticipant(
                        //         widget.activityId, authProvider.userData!.uid);
                        //   }
                        //   if (context.mounted) {
                        //     context.push(
                        //         "/${MyRouter.courses}/${widget.activityId}");
                        //   }
                        // }
                      },
                      style: ButtonStyle(
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 24)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                      ),
                      child: IgnorePointer(child: Text(_isParticipant ? "進入後台" : "報名參加"))),
                ),
              ]);
        },
      ),
    );
  }
}
