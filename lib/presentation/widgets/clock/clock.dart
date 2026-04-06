import "package:flutter/material.dart";
import "package:ticktock/core/types/time.dart";
import "package:ticktock/core/utils/color.dart";
import "package:ticktock/features/to_do/domain/to_do.dart";
import "package:ticktock/presentation/widgets/clock/clock_painter.dart";

class Clock extends StatefulWidget {
  final TimeModel time;
  final List<ToDo>? toDoItems;
  const Clock({super.key, required this.time, this.toDoItems});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
  Widget build(final BuildContext context) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: AppStyle.primaryColor.withAlpha(80), blurRadius: 38),
          ],
        ),
        height: 300,
        width: 300,
        child: CustomPaint(
          painter: ClockPainter(widget.time, widget.toDoItems),
        ),
      );
}
