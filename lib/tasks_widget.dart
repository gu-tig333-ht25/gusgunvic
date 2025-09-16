import 'package:flutter/material.dart';

// This is a custom ListTile widget that includes a checkbox and a delete icon.
class CustomListTile extends StatelessWidget {
  final String title;
  final bool isChecked;
  final Function(bool?) checkboxCallback;
  final Function() deleteCallback;
  const CustomListTile({
    super.key,
    required this.title,
    required this.isChecked,
    required this.checkboxCallback,
    required this.deleteCallback,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          decoration: isChecked
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      value: isChecked,
      onChanged: checkboxCallback,
      controlAffinity: ListTileControlAffinity.leading,
      secondary: GestureDetector(
        onTap: deleteCallback,
        child: Icon(Icons.close),
      ),
    );
  }
}
