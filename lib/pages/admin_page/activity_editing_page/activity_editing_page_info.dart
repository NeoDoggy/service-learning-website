import 'dart:typed_data';

import 'package:date_field/date_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user/user_permission.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';

class ActivityEditingPageInfo extends StatefulWidget {
  const ActivityEditingPageInfo(
    this.id, {
    super.key,
  });

  final String id;

  @override
  State<ActivityEditingPageInfo> createState() =>
      _ActivityEditingPageInfoState();
}

class _ActivityEditingPageInfoState extends State<ActivityEditingPageInfo> {
  final _titleTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _placeTextController = TextEditingController();
  final _audienceTextController = TextEditingController();
  final _feeTextController = TextEditingController();
  final _goalTextController = TextEditingController();

  bool _isEdited = false;
  bool _canEdit = false;
  bool _imageEdited = false;
  Uint8List? _imageByte;

  @override
  void dispose() {
    _titleTextController.dispose();
    _descriptionTextController.dispose();
    _audienceTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ActivitiesProvider>(
      builder: (context, authProvider, activitiesProvider, child) {
        final activityData = activitiesProvider.activitiesData[widget.id]!;
        _canEdit = (authProvider.userData?.permission ?? UserPermission.none) >=
                UserPermission.ta ||
            activityData.members.contains(authProvider.userData?.uid);

        if (!_isEdited) {
          _titleTextController.text = activityData.title;
          _descriptionTextController.text = activityData.description;
          _placeTextController.text = activityData.place;
          _audienceTextController.text = activityData.audience;
          _feeTextController.text = activityData.fee;
          _goalTextController.text = activityData.goal;
          if (_imageByte == null && activityData.imageUrl != "") {
            http
                .get(Uri.parse(activityData.imageUrl))
                .timeout(const Duration(seconds: 5))
                .then((response) =>
                    setState(() => _imageByte = response.bodyBytes))
                .catchError((_) => setState(() => _imageByte = null));
          }
        }

        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_isEdited)
                ElevatedButton(
                    onPressed: () {
                      activityData.title = _titleTextController.text;
                      activityData.description =
                          _descriptionTextController.text;
                      activityData.place = _placeTextController.text;
                      activityData.audience = _audienceTextController.text;
                      activityData.fee = _feeTextController.text;
                      activityData.goal = _goalTextController.text;
                      activitiesProvider.updateActivity(widget.id,
                          image: _imageEdited ? _imageByte : null);
                      setState(() => _isEdited = false);
                    },
                    child: const Text("儲存變更")),
              if (_isEdited) const SizedBox(height: 40),
              TextField(
                readOnly: !_canEdit,
                controller: _titleTextController,
                onChanged: (_) => setState(() => _isEdited = true),
                decoration: const InputDecoration(
                  labelText: "課程標題",
                  icon: Icon(Icons.text_fields),
                ),
              ),
              TextField(
                readOnly: !_canEdit,
                controller: _placeTextController,
                onChanged: (_) => setState(() => _isEdited = true),
                decoration: const InputDecoration(
                  labelText: "活動地點",
                  icon: Icon(Icons.place),
                ),
              ),
              DateTimeField(
                enabled: _canEdit,
                onDateSelected: (value) => setState(() {
                  activityData.deadline = value;
                  _isEdited = true;
                }),
                selectedDate: activityData.deadline,
                mode: DateTimeFieldPickerMode.date,
                decoration: const InputDecoration(
                  labelText: "報名截止日期",
                  icon: Icon(Icons.calendar_today),
                ),
              ),
              TextField(
                readOnly: !_canEdit,
                controller: _audienceTextController,
                onChanged: (_) => setState(() => _isEdited = true),
                decoration: const InputDecoration(
                  labelText: "適合對象",
                  icon: Icon(Icons.people),
                ),
              ),
              TextField(
                readOnly: !_canEdit,
                controller: _feeTextController,
                onChanged: (_) => setState(() => _isEdited = true),
                decoration: const InputDecoration(
                  labelText: "費用",
                  icon: Icon(Icons.attach_money),
                ),
              ),
              TextField(
                readOnly: !_canEdit,
                controller: _goalTextController,
                onChanged: (_) => setState(() => _isEdited = true),
                decoration: const InputDecoration(
                  labelText: "課程目標",
                  icon: Icon(Icons.track_changes),
                ),
              ),
              TextField(
                readOnly: !_canEdit,
                controller: _descriptionTextController,
                onChanged: (_) => setState(() => _isEdited = true),
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: "內容說明",
                  hintText: "可換行輸入",
                  icon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 40),
              Row(children: [
                const Text("課程預覽圖片"),
                if (_canEdit) const SizedBox(width: 10),
                if (_canEdit)
                  ElevatedButton(
                      onPressed: () => _pickFile(), child: const Text("瀏覽檔案")),
              ]),
              const SizedBox(height: 20),
              if (_imageByte != null) Image.memory(_imageByte!, width: 400),
              if (_imageByte == null)
                const SizedBox(width: 400, child: Placeholder()),
            ]);
      },
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      setState(() {
        _imageByte = result.files.first.bytes;
        _isEdited = true;
        _imageEdited = true;
      });
    }
  }
}
