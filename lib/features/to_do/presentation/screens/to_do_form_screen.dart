import "package:flutter/material.dart";
import "package:tick_tock/features/to_do/domain/to_do.dart";
import "package:tick_tock/features/to_do/presentation/widgets/to_do_form.dart";

class ToDoFormScreen extends StatefulWidget {
  final ToDo? toDoItem;

  const ToDoFormScreen({super.key, this.toDoItem});

  @override
  State<ToDoFormScreen> createState() => _ToDoFormScreenState();
}

class _ToDoFormScreenState extends State<ToDoFormScreen> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.toDoItem == null ? "Add To Do" : "To Do"),
        ),
        body: ToDoForm(toDoItem: widget.toDoItem),
      );
}
