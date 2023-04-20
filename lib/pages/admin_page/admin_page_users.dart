import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/providers/admin_page_users_provider.dart';

class AdminPageUsers extends StatefulWidget {

  const AdminPageUsers({super.key});

  @override
  State<AdminPageUsers> createState() => _AdminPageUsersState();
}

class _AdminPageUsersState extends State<AdminPageUsers> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminPageUsersProvider>(
      builder: (context, value, child) {
        value.load();
        return DataTable(
          columns: const [
            DataColumn(label: Text("名稱")),
            DataColumn(label: Text("UID")),
            DataColumn(label: Text("Email")),
            DataColumn(label: Text("權限")),
            DataColumn(label: Text("學號")),
          ],
          rows: [
            for (var userData in value.usersData)
              DataRow(
                cells: [
                  DataCell(SelectableText(userData.name ?? "<name>")),
                  DataCell(SelectableText(userData.uid)),
                  DataCell(SelectableText(userData.email ?? "<email>")),
                  DataCell(SelectableText(userData.permission.name)),
                  DataCell(SelectableText(userData.studentId.toString())),
                ]
              )
          ],
        );
      }
    );
  }
}