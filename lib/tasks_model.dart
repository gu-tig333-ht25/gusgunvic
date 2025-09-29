import 'dart:collection';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'backend_api.dart' as backend;

class Task {
  String title;
  bool isDone;
  String id;

  Task({required this.title, this.isDone = false, this.id = ''});

  void setDoneState(isDone) {
    this.isDone = isDone;
  }
}

class TasksList extends ChangeNotifier {
  // Local copy of the tasks
  List<Task> _tasks = [];

  // Getters to access filtered tasks
  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  UnmodifiableListView<Task> get doneTasks {
    return UnmodifiableListView(_tasks.where((task) => task.isDone));
  }

  UnmodifiableListView<Task> get undoneTasks {
    return UnmodifiableListView(_tasks.where((task) => !task.isDone));
  }

  // Fetch all tasks from the backend server
  Future<void> fetchTasks() async {
    print('Fetching tasks from server...');
    backend
        .getTasksJSON()
        .then((jsonString) {
          updateTasksWithJSON(jsonString);
        })
        .catchError((error) {
          print("Error fetching tasks: $error");
        });
  }

  // Add a task to the backend server
  Future<void> addTask(String title, bool isDone) async {
    if (title.isEmpty) return;

    backend
        .postTask(title, isDone)
        .then((jsonString) {
          updateTasksWithJSON(jsonString);
        })
        .catchError((error) {
          print("Error adding task: $error");
        });
  }

  // Update a task on the backend server
  Future<void> setDone(Task task, bool isDone) async {
    int statusCode = await backend.updateTask(task.title, task.id, isDone);

    if (statusCode == 200) {
      task.setDoneState(isDone);
      notifyListeners();
    }
  }

  // Delete a task on the backend server
  Future<void> removeTask(Task task) async {
    int statusCode = await backend.deleteTask(task.id);

    if (statusCode == 200) {
      // Remove the task from the local list using the ID
      // (the object cannot be used directly since the instance is updated by each call to getTasks)
      for (var t in _tasks) {
        if (t.id == task.id) {
          _tasks.remove(t);
          break;
        }
      }
      notifyListeners();
    }
  }

  // Update the local task list from a JSON string
  void updateTasksWithJSON(String jsonString) {
    var returnedTasks = jsonDecode(jsonString);
    _tasks = [];
    for (var t in returnedTasks) {
      if (t['title'] == null) continue;
      _tasks.add(Task(title: t['title'], isDone: t['done'], id: t['id']));
    }
    notifyListeners();
  }
}
