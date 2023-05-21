import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/widgets/download_button.dart';

class BackstageActivityPageFile extends StatefulWidget {
  const BackstageActivityPageFile(
    this.activityId, {
    super.key,
  });

  final String activityId;

  @override
  State<BackstageActivityPageFile> createState() =>
      BackstageActivityPageFileState();
}

class BackstageActivityPageFileState extends State<BackstageActivityPageFile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ActivitiesProvider>(
      builder: (context, activitiesProvider, child) {
        final activityData =
            activitiesProvider.activitiesData[widget.activityId]!;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var fileData in activityData.files.values)
              DownloadButton(url: fileData.url, filename: fileData.filename)
          ],
        );
      },
    );
  }
}
