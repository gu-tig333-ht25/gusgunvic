import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tasks_model.dart';

// This file contains the second screen of the app, which allows users to add new to-do items.

class ScreenAdd extends StatelessWidget {
  const ScreenAdd({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('TIG333 TODO'),
        backgroundColor: Color.fromARGB(255, 30, 30, 30),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'What are you going to do?',
                  hintText: 'Enter your task here',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle add item action
                String newTaskTitle = controller.text.trim();
                Provider.of<TasksList>(
                  context,
                  listen: false,
                ).addTask(newTaskTitle, false);
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 30),
                  SizedBox(width: 4),
                  const Text('ADD', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
