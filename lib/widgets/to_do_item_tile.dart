import 'package:flutter/material.dart';
import 'package:tick_tock/database/database_service.dart';
import 'package:tick_tock/models/to_do_item.dart';
import 'package:tick_tock/screens/to_do_manage_screen.dart';
import 'package:tick_tock/utils/color.dart';

class ToDoItemTile extends StatelessWidget {
  final Color iconColor;
  final ToDoItem toDoItem;
  final VoidCallback onDelete;
  const ToDoItemTile({
    super.key,
    required this.iconColor,
    required this.toDoItem,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ToDoManageScreen(
                toDoItem: toDoItem,
              ),
            ),
          );
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
          toDoItem.title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
