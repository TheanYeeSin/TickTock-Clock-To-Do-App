import 'package:flutter/material.dart';
import 'package:tick_tock/database/database_service.dart';
import 'package:tick_tock/features/to_do/domain/to_do.dart';
import 'package:tick_tock/features/to_do/presentation/screens/to_do_form_screen.dart';
import 'package:tick_tock/core/utils/color.dart';

class ToDoTile extends StatefulWidget {
  final Color iconColor;
  final ToDo toDoItem;
  final VoidCallback onDelete;
  const ToDoTile({
    super.key,
    required this.iconColor,
    required this.toDoItem,
    required this.onDelete,
  });

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ToDoFormScreen(
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
            await DatabaseService.updateToDoComplete(
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
