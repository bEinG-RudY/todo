import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo/model/task_model.dart';

class TaskViewmodel extends ChangeNotifier {
  List<Task> tasks = [];

  String? taskName;
  final dateCont = TextEditingController();
  final timeCont = TextEditingController();

  // ignore: unrelated_type_equality_checks
  bool get isValid =>
      taskName != null && dateCont.text.isNotEmpty && timeCont.text.isNotEmpty;

  setTaskName(String? value) {
    taskName = value;
    notifyListeners();
  }

  setDate(DateTime? date) {
    if (date == null) {
      return;
    }
    DateTime currentDate = DateTime.now();
    DateTime now =
        DateTime(currentDate.year, currentDate.month, currentDate.day);

    int diff = date.difference(now).inDays;

    if (diff == 0) {
      dateCont.text = "Today";
    } else if (diff == 1) {
      dateCont.text = "tomorrow";
    } else {
      dateCont.text = "${date.day}-${date.month}-${date.year}";
    }
    notifyListeners();
  }

  setTime(TimeOfDay? time) {
    if (time == null) {
      return;
    }
    if (time.hour == 0) {
      timeCont.text = "12:${time.minute} AM";
    } else if (time.hour < 12) {
      timeCont.text = "${time.hour}:${time.minute} AM";
    } else if (time.hashCode == 12) {
      timeCont.text = "${time.hour}:${time.minute} PM";
    } else {
      timeCont.text = "${time.hour - 12}:${time.minute} PM";
    }
    notifyListeners();
  }

  addTask() {
    if (!isValid) {
      return;
    }
    final task =
        Task(taskName: taskName!, date: dateCont.text, time: timeCont.text);
    tasks.add(task);
    timeCont.clear();
    dateCont.clear();

    notifyListeners();
  }
}
