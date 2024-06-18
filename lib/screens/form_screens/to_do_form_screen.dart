import 'package:flutter/material.dart';
import 'package:tick_tock/models/to_do_item.dart';
import 'package:tick_tock/widgets/common/form/to_do_form.dart';

class ToDoFormScreen extends StatefulWidget {
  final ToDoItem? toDoItem;

  const ToDoFormScreen({super.key, this.toDoItem});

  @override
  State<ToDoFormScreen> createState() => _ToDoFormScreenState();
}

class _ToDoFormScreenState extends State<ToDoFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.toDoItem == null ? "Add To Do" : "To Do"),
      ),
      body: ToDoForm(toDoItem: widget.toDoItem),
    );
  }
}
