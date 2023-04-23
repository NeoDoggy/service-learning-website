import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';
import 'package:service_learning_website/providers/admin_page_users_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/widgets/text/modifiable_text.dart';

class AdminPageUsers extends StatelessWidget {

  const AdminPageUsers({super.key});

  @override
  Widget build(BuildContext context) {

    final pageProvider = Provider.of<AdminPageUsersProvider>(context);
    pageProvider.load();

    return Consumer2<AdminPageUsersProvider, AuthProvider>(
      builder: (context, pageProvider, authProvider, child) {

        UserPermission permission = authProvider.userData?.permission
          ?? UserPermission.none;

        if (permission < UserPermission.ta) {
          return const Text("你沒有權限");
        }

        return DataTable(
          columns: const [
            DataColumn(label: Text("名稱")),
            DataColumn(label: Text("UID")),
            DataColumn(label: Text("Email")),
            DataColumn(label: Text("權限")),
            DataColumn(label: Text("學號")),
          ],
          rows: [
            for (var userData in pageProvider.usersData)
              DataRow(
                cells: [
                  DataCell(SelectableText(userData.name ?? "<name>")),
                  DataCell(SelectableText(userData.uid)),
                  DataCell(SelectableText(userData.email ?? "<email>")),
                  DataCell(
                    Text(userData.permission.name),
                    showEditIcon: true,
                  ),
                  DataCell(
                    ModifiableText(
                      userData.studentId.toString(),
                      restriction: (input)
                        => _isInteger(input) && int.parse(input) >= 0,
                      onEditingCompleted: (input)
                        => pageProvider.updateStudentId(userData.uid, int.parse(input)),
                    ),
                    showEditIcon: true,
                  ),
                ]
              )
          ],
        );
      }
    );
  }

  bool _isInteger(String str) {
    return int.tryParse(str) != null;
  }
}