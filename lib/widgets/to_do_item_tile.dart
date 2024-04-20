import 'package:flutter/material.dart';
import 'package:tick_tock/database/database_service.dart';
import 'package:tick_tock/models/to_do_item.dart';
import 'package:tick_tock/screens/to_do_manage_screen.dart';
import 'package:tick_tock/utils/color.dart';

class ToDoItemTile extends StatefulWidget {
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
  State<ToDoItemTile> createState() => _ToDoItemTileState();
}

class _ToDoItemTileState extends State<ToDoItemTile> {
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
                toDoItem: widget.toDoItem,
              ),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: toDoTileColor,
        leading: Checkbox(
          value: widget.toDoItem.isCompleted,
          onChanged: (value) async {
            await DatabaseService.updateToDoItemComplete(
              widget.toDoItem.id!,
              value! ? 1 : 0,
            );
            setState(() {
              widget.toDoItem.isCompleted = value;
            });
          },
        ),
        title: Text(
          widget.toDoItem.title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: widget.onDelete,
        ),
      ),
    );
  }
}
