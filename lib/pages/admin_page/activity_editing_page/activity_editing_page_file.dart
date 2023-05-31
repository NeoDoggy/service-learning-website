import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user/user_permission.dart';
import 'package:service_learning_website/modules/url_downloader.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/widgets/text/modifiable_text.dart';

class ActivityEditingPageFile extends StatefulWidget {
  const ActivityEditingPageFile(
    this.id, {
    super.key,
  });

  final String id;

  @override
  State<ActivityEditingPageFile> createState() =>
      _ActivityEditingPageFileState();
}

class _ActivityEditingPageFileState extends State<ActivityEditingPageFile> {
  bool _canEdit = false;

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ActivitiesProvider>(
      builder: (context, authProvider, activitiesProvider, child) {
        final activityData = activitiesProvider.activitiesData[widget.id]!;
        _canEdit = (authProvider.userData?.permission ?? UserPermission.none) >=
                UserPermission.ta ||
            activityData.members.contains(authProvider.userData?.uid);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: _canEdit
                  ? () async {
                      final result = await FilePicker.platform
                          .pickFiles(type: FileType.any, allowMultiple: false);
                      if (result != null) {
                        activitiesProvider.uploadFile(widget.id,
                            result.files.first.name, result.files.first.bytes!);
                      }
                    }
                  : null,
              icon: const Icon(Icons.upload_file),
              label: const SelectionContainer.disabled(child: Text("上傳檔案")),
            ),
            const SizedBox(height: 40),
            DataTable(
              columns: const [
                DataColumn(label: Text("檔名")),
                DataColumn(label: Text("上傳日期")),
                DataColumn(label: Text("下載")),
                DataColumn(label: Text("刪除")),
              ],
              rows: [
                for (var fileData in activityData.files.values)
                  DataRow(
                    cells: [
                      DataCell(
                          _canEdit
                              ? ModifiableText(
                                  fileData.filename,
                                  onEditingCompleted: (value) {
                                    fileData.filename = value;
                                    activitiesProvider.updateFile(
                                        widget.id, fileData.id);
                                  },
                                )
                              : Text(fileData.filename),
                          showEditIcon: _canEdit),
                      DataCell(Text(DateFormat("yyyy/MM/dd")
                          .format(fileData.uploadedTime))),
                      DataCell(IconButton(
                        onPressed: () => UrlDownloader.download(
                            fileData.url, fileData.filename),
                        icon: const Icon(Icons.download),
                      )),
                      DataCell(IconButton(
                        onPressed: _canEdit
                            ? () => activitiesProvider.deleteFile(
                                widget.id, fileData.id)
                            : null,
                        icon: const Icon(Icons.delete),
                      )),
                    ],
                  ),
              ],
            )
          ],
        );
      },
    );
  }
}
