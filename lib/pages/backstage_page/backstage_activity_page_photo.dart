import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/activity/activity_file_data.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/widgets/image_preview.dart';
import 'package:http/http.dart' as http;

class BackstageActivityPagePhoto extends StatefulWidget {
  const BackstageActivityPagePhoto(
    this.activityId, {
    super.key,
  });

  final String activityId;

  @override
  State<BackstageActivityPagePhoto> createState() =>
      _BackstageActivityPagePhotoState();
}

class _BackstageActivityPagePhotoState
    extends State<BackstageActivityPagePhoto> {
  bool _imageLoaded = false;
  final Map<String, Uint8List> _imagesByte = {};
  late Map<String, ActivityFileData> _photos;

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivitiesProvider>(
      builder: (context, activitiesProvider, child) {
        _photos = activitiesProvider.activitiesData[widget.activityId]!.photos;
        if (!_imageLoaded) {
          _imageLoaded = true;
          _loadImages();
        }
        return Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          spacing: 20,
          runSpacing: 20,
          children: [
            for (var image in _imagesByte.entries)
              ImagePreview(
                width: 200,
                height: 200,
                image: image.value,
              ),
          ],
        );
      },
    );
  }

  Future<void> _loadImages() async {
    for (var fileData in _photos.values) {
      final response = await http
          .get(Uri.parse(fileData.url))
          .timeout(const Duration(seconds: 5));
      setState(() => _imagesByte[fileData.id] = response.bodyBytes);
    }
  }
}
