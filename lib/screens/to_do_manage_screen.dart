import 'package:flutter/material.dart';
import 'package:tick_tock/models/to_do_item.dart';
import 'package:tick_tock/widgets/to_do_form.dart';

class ToDoManageScreen extends StatefulWidget {
  final ToDoItem? toDoItem;

  const ToDoManageScreen({super.key, this.toDoItem});

  @override
  State<ToDoManageScreen> createState() => _ToDoManageScreenState();
}

class _ToDoManageScreenState extends State<ToDoManageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.toDoItem == null ? "Add To Do" : "Edit To Do"),
      ),
      body: ToDoForm(toDoItem: widget.toDoItem),
    );
  }
}
