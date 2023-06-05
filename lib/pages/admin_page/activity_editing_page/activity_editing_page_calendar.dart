import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/activity/activity_calendar_data.dart';
import 'package:service_learning_website/modules/backend/user/user_permission.dart';
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

        final calendar = activityData.calendar;
        if (!_isEdited) {
          calendar.sort((a, b) => a.date.compareTo(b.date));
          _morningControllers = calendar
              .map((e) => TextEditingController(text: e.morning))
              .toList();
          _afternoonControllers = calendar
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
                        calendar.add(ActivityCalendarData());
                        _morningControllers.add(TextEditingController());
                        _afternoonControllers.add(TextEditingController());
                        _isEdited = true;
                      });
                    },
                    child: const SelectionContainer.disabled(child: Text("新增")),
                  ),
                if (_canEdit) const SizedBox(width: 20),
                if (_isEdited)
                  ElevatedButton(
                    onPressed: () {
                      _isEdited = false;
                      for (int i = 0; i < calendar.length; i++) {
                        calendar[i].morning = _morningControllers[i].text;
                        calendar[i].afternoon = _afternoonControllers[i].text;
                      }
                      calendar.sort((a, b) => a.date.compareTo(b.date));
                      activitiesProvider.updateActivity(widget.id);
                    },
                    child: const SelectionContainer.disabled(child: Text("儲存變更")),
                  ),
              ],
            ),
            if (_canEdit || _isEdited) const SizedBox(height: 40),
            for (int i = 0; i < calendar.length; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DateTimeField(
                    enabled: _canEdit,
                    onDateSelected: (value) {
                      setState(() {
                        calendar[i].date = value;
                        _isEdited = true;
                      });
                    },
                    selectedDate: calendar[i].date,
                    mode: DateTimeFieldPickerMode.date,
                    decoration: const InputDecoration(
                      labelText: "日期",
                      icon: Icon(Icons.calendar_today),
                    ),
                  ),
                  DateTimeField(
                    enabled: _canEdit,
                    onDateSelected: (value) {
                      setState(() {
                        calendar[i].begin = value;
                        _isEdited = true;
                      });
                    },
                    selectedDate: calendar[i].begin,
                    mode: DateTimeFieldPickerMode.time,
                    decoration: const InputDecoration(
                      labelText: "開始時間",
                      icon: Icon(Icons.schedule),
                    ),
                  ),
                  DateTimeField(
                    enabled: _canEdit,
                    onDateSelected: (value) {
                      setState(() {
                        calendar[i].end = value;
                        _isEdited = true;
                      });
                    },
                    selectedDate: calendar[i].end,
                    mode: DateTimeFieldPickerMode.time,
                    decoration: const InputDecoration(
                      labelText: "結束時間",
                      icon: Icon(Icons.schedule),
                    ),
                  ),
                  TextField(
                    readOnly: !_canEdit,
                    controller: _morningControllers[i],
                    onChanged: (_) => setState(() => _isEdited = true),
                    decoration: const InputDecoration(
                      labelText: "上午行程",
                      icon: Icon(Icons.description),
                    ),
                  ),
                  TextField(
                    readOnly: !_canEdit,
                    controller: _afternoonControllers[i],
                    onChanged: (_) => setState(() => _isEdited = true),
                    decoration: const InputDecoration(
                      labelText: "下午行程",
                      icon: Icon(Icons.description),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () => setState(() {
                      calendar.removeAt(i);
                      _morningControllers[i].dispose();
                      _morningControllers.removeAt(i);
                      _afternoonControllers[i].dispose();
                      _afternoonControllers.removeAt(i);
                      _isEdited = true;
                    }),
                    child: const SelectionContainer.disabled(child: Text("刪除")),
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
