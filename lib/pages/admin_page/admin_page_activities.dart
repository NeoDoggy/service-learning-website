import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user/user_permission.dart';
import 'package:service_learning_website/modules/my_router.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';

class AdminPageActivities extends StatefulWidget {
  const AdminPageActivities({super.key});

  @override
  State<AdminPageActivities> createState() => _AdminPageActivitiesState();
}

class _AdminPageActivitiesState extends State<AdminPageActivities> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final UserPermission permission =
            authProvider.userData?.permission ?? UserPermission.none;

        return Consumer<ActivitiesProvider>(
          builder: (context, activitiesProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (permission >= UserPermission.ta)
                  ElevatedButton(
                    onPressed: () => activitiesProvider.createActivity(),
                    child: const IgnorePointer(child: Text("建立活動")),
                  ),
                if (permission >= UserPermission.ta) const SizedBox(height: 40),
                Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      showBottomBorder: true,
                      columns: const [
                        DataColumn(label: Text("標題")),
                        DataColumn(label: Text("建立日期")),
                        DataColumn(label: Text("瀏覽／編輯")),
                      ],
                      rows: [
                        for (var activityData
                            in activitiesProvider.activitiesData.values)
                          DataRow(
                            cells: [
                              DataCell(Text(activityData.title)),
                              DataCell(Text(DateFormat("yyyy-MM-dd")
                                  .format(activityData.createdTime))),
                              DataCell(
                                IconButton(
                                  onPressed: () => context.push(
                                      "/${MyRouter.admin}/${MyRouter.activities}/${activityData.id}"),
                                  icon: (permission >= UserPermission.ta ||
                                          activityData.members.contains(
                                              authProvider.userData!.uid))
                                      ? const Icon(Icons.edit)
                                      : const Icon(Icons.visibility),
                                ),
                              ),
                            ],
                          ),
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
}
