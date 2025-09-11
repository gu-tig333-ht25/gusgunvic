import 'package:flutter/material.dart';
import 'screen_list.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(colorScheme: ColorScheme.dark(), useMaterial3: true),
      home: ScreenList(), // Entry point of the app is the ScreenList
    );
  }
}
