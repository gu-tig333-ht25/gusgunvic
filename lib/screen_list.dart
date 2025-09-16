import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen_add.dart';
import 'tasks_model.dart';
import 'tasks_widget.dart';

// This is the main screen that displays the list of to-do items.
class ScreenList extends StatelessWidget {
  ScreenList({super.key});

  // Function to generate a list of CustomListTile widgets from the tasks.
  List<CustomListTile> getListTiles(context) {
    var tasksModel = Provider.of<TasksList>(context);
    List<Task> taskList = tasksModel.tasks;

    List<CustomListTile> tiles = taskList
        .map(
          (task) => CustomListTile(
            title: task.title,
            isChecked: task.isDone,
            checkboxCallback: (value) {
              Provider.of<TasksList>(
                context,
                listen: false,
              ).setDone(task, value!);
            },
          ),
        )
        .toList();
    return tiles;
  }

  // Build function to create the UI of the screen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TIG333 TODO'),
        backgroundColor: Color.fromARGB(255, 30, 30, 30),
        actions: popupMenu(),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          color: Color.fromARGB(255, 72, 71, 71),
          context: context,
          tiles: getListTiles(context),
        ).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(side: BorderSide(color: Colors.black, width: 2.0)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScreenAdd()),
          );
        },
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }
}

// The appbar popup menu for filtering the to-do list.
List<Widget> popupMenu() {
  return <Widget>[
    PopupMenuButton<String>(
      icon: Icon(Icons.more_vert),
      onSelected: handleClick,
      itemBuilder: (BuildContext context) {
        return ['All', 'Done', 'Undone'].map((String choice) {
          return PopupMenuItem<String>(value: choice, child: Text(choice));
        }).toList();
      },
    ),
  ];
}

void handleClick(String value) {
  switch (value) {
    case 'All':
      break; // 2do: implement filter logic
    case 'Done':
      break;
    case 'Undone':
      break;
  }
}
