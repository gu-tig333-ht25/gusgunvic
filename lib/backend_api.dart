import 'package:http/http.dart' as http;
import 'dart:convert';

const API_KEY = '377a8dde-c051-4a16-8e0a-3d9bb1751b03';
const API_URL = 'https://todoapp-api.apps.k8s.gu.se';

// Fetch all tasks from the backend server
Future<String> getTasksJSON() async {
  http.Response response;
  response = await http.get(Uri.parse("$API_URL/todos?key=$API_KEY"));
  if (response.statusCode == 200) {
    // OK
    return (response.body);
  } else {
    print("HTTP GET Error: ${response.statusCode}");
    return Future.error("HTTP GET Error");
  }
}

// Add a task to the backend server
// Returns JSON list of tasks if successful
Future<String> postTask(String title, bool isDone) async {
  if (title.isEmpty) return "";

  Map<String, dynamic> jsonTasks = {'title': title, 'done': isDone};

  String jsonString = jsonEncode(jsonTasks);
  http.Response response;
  response = await http.post(
    Uri.parse("$API_URL/todos?key=$API_KEY"),
    headers: {"Content-Type": "application/json"},
    body: jsonString,
  );
  if (response.statusCode == 200) {
    // OK
    return (response.body);
  } else {
    print("HTTP POST Error: ${response.statusCode}");
    return Future.error("HTTP POST Error");
  }
}

// Update a task on the backend server
Future<int> updateTask(String title, String id, bool isDone) async {
  Map<String, dynamic> jsonTasks = {'title': title, 'done': isDone};
  String jsonString = jsonEncode(jsonTasks);
  http.Response response;
  response = await http.put(
    Uri.parse("$API_URL/todos/$id?key=$API_KEY"),
    headers: {"Content-Type": "application/json"},
    body: jsonString,
  );
  if (response.statusCode != 200) {
    print("HTTP PUT Error: ${response.statusCode}");
  }
  return response.statusCode;
}

// Delete a task on the backend server
Future<int> deleteTask(String id) async {
  http.Response response;
  response = await http.delete(Uri.parse("$API_URL/todos/$id?key=$API_KEY"));
  if (response.statusCode != 200) {
    print("HTTP PUT Error: ${response.statusCode}");
  }
  return response.statusCode;
}
