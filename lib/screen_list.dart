import 'package:flutter/material.dart';
import 'screen_add.dart';

// This file contains the first screen of the app, which displays a list of to-do items.

// This is a custom ListTile widget that includes a checkbox and a delete icon.
class CustomListTile extends CheckboxListTile {
  CustomListTile({super.key, required String title})
    : super(
        title: Text(title, style: const TextStyle(fontSize: 20)),
        value: false,
        onChanged: (value) {},
        controlAffinity: ListTileControlAffinity.leading,
        secondary: GestureDetector(
          child: Icon(Icons.close),
          onTap: () {
            // Handle delete action
          },
        ),
      );
}

class ScreenList extends StatelessWidget {
  const ScreenList({super.key});

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
          tiles: [
            CustomListTile(title: 'Item 1'),
            CustomListTile(title: 'Item 2'),
            CustomListTile(title: 'Item 3'),
          ],
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
