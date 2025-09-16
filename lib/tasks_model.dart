import 'dart:collection';
import 'package:flutter/material.dart';

class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});

  void setDoneState(isDone) {
    this.isDone = isDone;
  }
}

class TasksList extends ChangeNotifier {
  List<Task> _tasks = [Task(title: 'Sample Task 1', isDone: false)];

  // Getters to access tasks
  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);
  UnmodifiableListView<Task> get doneTasks =>
      UnmodifiableListView(_tasks.where((task) => task.isDone));
  UnmodifiableListView<Task> get undoneTasks =>
      UnmodifiableListView(_tasks.where((task) => !task.isDone));

  void addTask(String title, bool isDone) {
    if (title.isEmpty) return;
    _tasks.add(Task(title: title, isDone: isDone));
    notifyListeners();
  }

  void setDone(Task task, bool isDone) {
    task.setDoneState(isDone);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
