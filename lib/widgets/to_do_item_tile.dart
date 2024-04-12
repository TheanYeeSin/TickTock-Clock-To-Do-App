import 'package:flutter/material.dart';
import 'package:tick_tock/utils/color.dart';

class ToDoItemTile extends StatelessWidget {
  final Color iconColor;
  final String toDoTitle;
  const ToDoItemTile({
    super.key,
    required this.iconColor,
    required this.toDoTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          //TODO: View To Do
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: toDoTileColor,
        leading: Icon(
          Icons.circle_outlined,
          color: iconColor,
        ),
        title: Text(
          toDoTitle,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            decoration: TextDecoration.lineThrough,
          ),
        ),
      ),
    );
  }
}
