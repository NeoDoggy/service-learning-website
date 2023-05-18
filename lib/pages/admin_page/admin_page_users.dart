import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user/user_permission.dart';
import 'package:service_learning_website/providers/users_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/widgets/permission_denied.dart';
import 'package:service_learning_website/widgets/text/choosable_text.dart';
import 'package:service_learning_website/widgets/text/modifiable_text.dart';

class AdminPageUsers extends StatefulWidget {
  const AdminPageUsers({super.key});

  @override
  State<AdminPageUsers> createState() => _AdminPageUsersState();
}

class _AdminPageUsersState extends State<AdminPageUsers> {
  late final TextEditingController _textController;
  late final ScrollController _scrollController;
  final _focusNode = FocusNode();

  String _keyword = "";

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: "");
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final UserPermission permission =
            authProvider.userData?.permission ?? UserPermission.none;

        if (permission < UserPermission.ta) {
          return const PermissionDenied();
        }

        return Consumer<UsersProvider>(
          builder: (context, usersProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("搜尋"),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: TextField(
                          controller: _textController,
                          focusNode: _focusNode,
                          textInputAction: TextInputAction.done,
                          onTapOutside: (_) {
                            _focusNode.unfocus();
                            _filter(_textController.text);
                          },
                          onEditingComplete: () =>
                              _filter(_textController.text),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      showBottomBorder: true,
                      columns: const [
                        DataColumn(label: Text("名稱")),
                        DataColumn(label: Text("UID")),
                        DataColumn(label: Text("Email")),
                        DataColumn(label: Text("權限")),
                        DataColumn(label: Text("學號")),
                      ],
                      rows: [
                        for (var userData in usersProvider.usersData.values
                            .where((element) => (element.uid
                                    .contains(_keyword) ||
                                element.name.contains(_keyword) ||
                                element.email.contains(_keyword) ||
                                element.studentId
                                    .toString()
                                    .contains(_keyword) ||
                                element.permission.name.contains(_keyword))))
                          DataRow(cells: [
                            DataCell(SelectableText(userData.name)),
                            DataCell(SelectableText(userData.uid)),
                            DataCell(SelectableText(userData.email)),
                            DataCell(
                              ChoosableText(
                                items: UserPermission.values
                                    .map((e) => e.name)
                                    .toList(),
                                defaultIndex: userData.permission.index,
                                disabledIndex: const [0],
                                onSelected: (index) =>
                                    usersProvider.updatePermission(userData.uid,
                                        UserPermission.values[index]),
                              ),
                              showEditIcon: true,
                            ),
                            DataCell(
                              ModifiableText(
                                userData.studentId.toString(),
                                restriction: (input) =>
                                    _isInteger(input) &&
                                    int.parse(input) != userData.studentId,
                                onEditingCompleted: (input) =>
                                    usersProvider.updateStudentId(
                                        userData.uid, int.parse(input)),
                              ),
                              showEditIcon: true,
                            ),
                          ])
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  bool _isInteger(String str) {
    return int.tryParse(str) != null;
  }

  void _filter(String keyword) {
    setState(() => _keyword = keyword);
  }
}
