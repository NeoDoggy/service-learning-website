import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/activity/activity_file_data.dart';
import 'package:service_learning_website/modules/backend/user/user_permission.dart';
import 'package:service_learning_website/modules/url_downloader.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/widgets/image_preview.dart';
import 'package:service_learning_website/widgets/text/modifiable_text.dart';

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
  late Map<String, ActivityFileData> _photos;

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
              label: const SelectionContainer.disabled(child: Text("上傳照片")),
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
                    ImagePreview(
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
                                  _photos[image.key]!.filename,
                                  onEditingCompleted: (value) {
                                    _photos[image.key]!.filename = value;
                                    activitiesProvider.updatePhoto(
                                        widget.id, image.key);
                                  },
                                )
                              else
                                Text(_photos[image.key]!.filename),
                              if (_canEdit) const Icon(Icons.edit),
                            ],
                          ),
                          // Text("檔名：${_photos[image.key]!.filename}"),
                          Text(
                              "上傳時間：${DateFormat('yyyy/MM/dd HH:mm:ss').format(_photos[image.key]!.uploadedTime)}"),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                  onPressed: () => UrlDownloader.download(
                                      _photos[image.key]!.url,
                                      _photos[image.key]!.filename),
                                  icon: const Icon(Icons.download),
                                  label: const SelectionContainer.disabled(
                                      child: Text("下載"))),
                              const SizedBox(width: 20),
                              ElevatedButton.icon(
                                  onPressed: _canEdit
                                      ? () {
                                          activitiesProvider.deletePhoto(
                                              widget.id, image.key);
                                          setState(() =>
                                              _imagesByte.remove(image.key));
                                        }
                                      : null,
                                  icon: const Icon(Icons.delete),
                                  label: const SelectionContainer.disabled(
                                      child: Text("刪除"))),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              );
            }),
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
