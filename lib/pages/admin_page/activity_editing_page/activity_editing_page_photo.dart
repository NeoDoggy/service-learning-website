import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/activity/activity_file_data.dart';
import 'package:service_learning_website/modules/backend/user/user_permission.dart';
import 'package:service_learning_website/modules/url_downloader.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/widgets/image_preview.dart';
import 'package:service_learning_website/widgets/text/modifiable_text.dart';
import 'package:http/http.dart' as http;

class ActivityEditingPagePhoto extends StatefulWidget {
  const ActivityEditingPagePhoto(
    this.id, {
    super.key,
  });

  final String id;

  @override
  State<ActivityEditingPagePhoto> createState() =>
      _ActivityEditingPagePhotoState();
}

class _ActivityEditingPagePhotoState extends State<ActivityEditingPagePhoto> {
  bool _canEdit = false;
  bool _imageLoaded = false;
  final Map<String, Uint8List> _imagesByte = {};
  late List<ActivityFileData> _photos;

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ActivitiesProvider>(
      builder: (context, authProvider, activitiesProvider, child) {
        final activityData = activitiesProvider.activitiesData[widget.id]!;
        _photos = activityData.photos;
        _canEdit = (authProvider.userData?.permission ?? UserPermission.none) >=
                UserPermission.ta ||
            activityData.members.contains(authProvider.userData?.uid);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: _canEdit
                  ? () async {
                      final result = await FilePicker.platform.pickFiles(
                          type: FileType.image, allowMultiple: false);
                      if (result != null) {
                        final fileId = await activitiesProvider.uploadPhoto(
                            widget.id,
                            result.files.first.name,
                            result.files.first.bytes!);
                        setState(() =>
                            _imagesByte[fileId] = result.files.first.bytes!);
                      }
                    }
                  : null,
              icon: const Icon(Icons.upload_file),
              label: const Text("上傳照片"),
            ),
            const SizedBox(height: 40),
            Builder(builder: (context) {
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
                    Builder(builder: (context) {
                      final fileData = activityData.photos
                          .firstWhere((e) => e.id == image.key);
                      return ImagePreview(
                        width: 200,
                        height: 200,
                        image: image.value,
                        sideWidget: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text("檔名："),
                                if (_canEdit)
                                  ModifiableText(
                                    fileData.filename,
                                    onEditingCompleted: (value) {
                                      fileData.filename = value;
                                      activitiesProvider
                                          .updateActivity(widget.id);
                                    },
                                  )
                                else
                                  Text(fileData.filename),
                                const Icon(Icons.edit),
                              ],
                            ),
                            Text(
                                "上傳時間：${DateFormat('yyyy/MM/dd HH:mm:ss').format(fileData.uploadedTime)}"),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                ElevatedButton.icon(
                                    onPressed: () => UrlDownloader.download(
                                        fileData.url, fileData.filename),
                                    icon: const Icon(Icons.download),
                                    label: const Text("下載")),
                                const SizedBox(width: 20),
                                ElevatedButton.icon(
                                    onPressed: _canEdit
                                        ? () {
                                            activitiesProvider.deletePhoto(
                                                widget.id, fileData.id);
                                            setState(() => _imagesByte
                                                .remove(fileData.id));
                                          }
                                        : null,
                                    icon: const Icon(Icons.delete),
                                    label: const Text("刪除")),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                ],
              );
            }),
          ],
        );
      },
    );
  }

  Future<void> _loadImages() async {
    for (var fileData in _photos) {
      final response = await http
          .get(Uri.parse(fileData.url))
          .timeout(const Duration(seconds: 5));
      setState(() => _imagesByte[fileData.id] = response.bodyBytes);
    }
  }
}
