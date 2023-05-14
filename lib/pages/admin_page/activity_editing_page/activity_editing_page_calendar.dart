import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/activity_calendar_data.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';

class ActivityEditingPageCalendar extends StatefulWidget {
  const ActivityEditingPageCalendar(
    this.id, {
    super.key,
  });

  final String id;

  @override
  State<ActivityEditingPageCalendar> createState() =>
      _ActivityEditingPageCalendarState();
}

class _ActivityEditingPageCalendarState
    extends State<ActivityEditingPageCalendar> {
  List<TextEditingController> _morningControllers = [];
  List<TextEditingController> _afternoonControllers = [];

  bool _isEdited = false;
  bool _canEdit = false;

  @override
  void dispose() {
    for (var controller in _morningControllers) {
      controller.dispose();
    }
    for (var controller in _afternoonControllers) {
      controller.dispose();
    }
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

        final calender = activityData.calendar;
        if (!_isEdited) {
          calender.sort((a, b) => a.date.compareTo(b.date));
          _morningControllers = calender
              .map((e) => TextEditingController(text: e.morning))
              .toList();
          _afternoonControllers = calender
              .map((e) => TextEditingController(text: e.afternoon))
              .toList();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (_canEdit)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calender.add(ActivityCalendarData());
                        _morningControllers.add(TextEditingController());
                        _afternoonControllers.add(TextEditingController());
                        _isEdited = true;
                      });
                    },
                    child: const Text("新增"),
                  ),
                if (_canEdit) const SizedBox(width: 20),
                if (_isEdited)
                  ElevatedButton(
                    onPressed: () {
                      for (int i = 0; i < calender.length; i++) {
                        calender[i].morning = _morningControllers[i].text;
                        calender[i].afternoon = _afternoonControllers[i].text;
                      }
                      calender.sort((a, b) => a.date.compareTo(b.date));
                      activitiesProvider.updateActivity(widget.id);
                      _isEdited = false;
                    },
                    child: const Text("儲存變更"),
                  ),
              ],
            ),
            if (_canEdit || _isEdited) const SizedBox(height: 40),
            for (int i = 0; i < calender.length; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DateTimeField(
                    enabled: _canEdit,
                    onDateSelected: (value) {
                      setState(() {
                        calender[i].date = value;
                        _isEdited = true;
                      });
                    },
                    selectedDate: calender[i].date,
                    mode: DateTimeFieldPickerMode.date,
                    decoration: const InputDecoration(
                      labelText: "日期",
                      icon: Icon(Icons.calendar_today),
                    ),
                  ),
                  TextField(
                    readOnly: !_canEdit,
                    controller: _morningControllers[i],
                    onChanged: (_) => setState(() => _isEdited = true),
                    decoration: const InputDecoration(
                      labelText: "上午行程",
                      icon: Icon(Icons.schedule),
                    ),
                  ),
                  TextField(
                    readOnly: !_canEdit,
                    controller: _afternoonControllers[i],
                    onChanged: (_) => setState(() => _isEdited = true),
                    decoration: const InputDecoration(
                      labelText: "下午行程",
                      icon: Icon(Icons.schedule),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () => setState(() {
                      calender.removeAt(i);
                      _morningControllers.removeAt(i);
                      _afternoonControllers.removeAt(i);
                      _isEdited = true;
                    }),
                    child: const Text("刪除"),
                  ),
                  const Divider(height: 40),
                ],
              ),
          ],
        );
      },
    );
  }
}
