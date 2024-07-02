import 'package:flutter/material.dart';
import 'package:tick_tock/models/to_do_item.dart';
import 'package:tick_tock/utils/color.dart';
import 'package:tick_tock/utils/time.dart';
import 'package:tick_tock/widgets/clock/clock_painter.dart';

class Clock extends StatefulWidget {
  final TimeModel time;
  final List<ToDoItem>? toDoItems;
  const Clock({super.key, required this.time, this.toDoItems});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: AppStyle.primaryColor.withAlpha(80), blurRadius: 38),
        ],
      ),
      height: 300,
      width: 300,
      child: CustomPaint(
        painter: ClockPainter(widget.time, widget.toDoItems),
      ),
    );
  }
}
