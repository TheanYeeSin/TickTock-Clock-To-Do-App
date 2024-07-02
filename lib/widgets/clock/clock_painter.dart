import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tick_tock/models/to_do_item.dart';
import 'package:tick_tock/utils/color.dart';
import 'package:tick_tock/utils/time.dart';

class ClockPainter extends CustomPainter {
  TimeModel? time;
  List<ToDoItem>? toDoItems;
  ClockPainter(this.time, this.toDoItems);

  @override
  void paint(Canvas canvas, Size size) {
    double secRad = ((pi / 2) - (pi / 30) * time!.sec!) % (2 * pi);
    double minRad = ((pi / 2) - (pi / 30) * time!.min!) % (2 * pi);
    double hourRad = ((pi / 2) - (pi / 6) * time!.hour!) % (2 * pi);

    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var secHeight = radius / 2;
    var minHeight = radius / 2 - 10;
    var hourHeight = radius / 2 - 35;

    var seconds = Offset(
      centerX + secHeight * cos(secRad),
      centerY - secHeight * sin(secRad),
    );
    var minutes = Offset(
      centerX + minHeight * cos(minRad),
      centerY - minHeight * sin(minRad),
    );
    var hours = Offset(
      centerX + hourHeight * cos(hourRad),
      centerY - hourHeight * sin(hourRad),
    );

    var fillBrush = Paint()
      ..color = AppStyle.primaryColor
      ..strokeCap = StrokeCap.round;

    var centerDotBrush = Paint()..color = const Color(0xFFEAECFF);

    var secBrush = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3
      ..strokeJoin = StrokeJoin.round;

    var minBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3
      ..strokeJoin = StrokeJoin.round;

    var hourBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3
      ..strokeJoin = StrokeJoin.round;

    canvas.drawCircle(center, radius - 40, fillBrush);

    canvas.drawLine(center, seconds, secBrush);
    canvas.drawLine(center, minutes, minBrush);
    canvas.drawLine(center, hours, hourBrush);

    canvas.drawCircle(center, 16, centerDotBrush);

    for (var item in toDoItems!) {
      drawToDoSegment(canvas, size, item);
    }
  }

  void drawToDoSegment(Canvas canvas, Size size, ToDoItem item) {
    if (item.startTime == null || item.endTime == null) return;

    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

// Calculate start and end angles in radians
    double startRad = ((item.startTime!.hour + 9) % 12) / 6 * pi;
    double endRad = ((item.endTime!.hour + 9) % 12) / 6 * pi;

    // print("startrad: ${startRad}");
    // print("endrad: ${endRad}");

    if (endRad <= startRad) {
      endRad += 2 * pi;
    }

// // Adjust for PM times by adding pi
    // if (item.startTime!.hour >= 12) startRad += pi;
    // if (item.endTime!.hour >= 12) endRad += pi;

// // Normalize angles to the range [0, 2*pi)
//     startRad = startRad % (2 * pi);
//     endRad = endRad % (2 * pi);

// // Adjust for end time being on the next day
//     if (endRad < startRad) endRad += 2 * pi;

    // print(startRad);

    var segmentBrush = Paint()
      ..color = Colors.black.withAlpha(100)
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: radius - 40),
        startRad,
        (endRad - startRad),
        false,
      )
      ..close();

    canvas.drawPath(path, segmentBrush);

    // Draw Label
    var textPainter = TextPainter(
      text: TextSpan(
        text: item.title,
        style: const TextStyle(color: Colors.black, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    double labelAngle = startRad + (endRad - startRad) / 2;
    var labelOffset = Offset(
      center.dx + (radius - 60) * cos(labelAngle) - textPainter.width / 2,
      center.dy - (radius - 60) * sin(labelAngle) - textPainter.height / 2,
    );
    textPainter.paint(canvas, labelOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
