import "dart:math";

import "package:flutter/material.dart";
import "package:tick_tock/core/types/time.dart";
import "package:tick_tock/core/utils/color.dart";
import "package:tick_tock/features/to_do/domain/to_do.dart";

class ClockPainter extends CustomPainter {
  TimeModel? time;
  List<ToDo>? toDoItems;
  ClockPainter(this.time, this.toDoItems);

  @override
  void paint(final Canvas canvas, final Size size) {
    final double secRad = ((pi / 2) - (pi / 30) * time!.sec!) % (2 * pi);
    final double minRad = ((pi / 2) - (pi / 30) * time!.min!) % (2 * pi);
    final double hourRad = ((pi / 2) - (pi / 6) * time!.hour!) % (2 * pi);

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min(centerX, centerY);

    final secHeight = radius / 2;
    final minHeight = radius / 2 - 10;
    final hourHeight = radius / 2 - 35;

    final seconds = Offset(
      centerX + secHeight * cos(secRad),
      centerY - secHeight * sin(secRad),
    );
    final minutes = Offset(
      centerX + minHeight * cos(minRad),
      centerY - minHeight * sin(minRad),
    );
    final hours = Offset(
      centerX + hourHeight * cos(hourRad),
      centerY - hourHeight * sin(hourRad),
    );

    final fillBrush = Paint()
      ..color = AppStyle.primaryColor
      ..strokeCap = StrokeCap.round;

    final centerDotBrush = Paint()..color = const Color(0xFFEAECFF);

    final secBrush = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3
      ..strokeJoin = StrokeJoin.round;

    final minBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3
      ..strokeJoin = StrokeJoin.round;

    final hourBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3
      ..strokeJoin = StrokeJoin.round;

    canvas
      ..drawCircle(center, radius - 40, fillBrush)
      ..drawLine(center, seconds, secBrush)
      ..drawLine(center, minutes, minBrush)
      ..drawLine(center, hours, hourBrush)
      ..drawCircle(center, 16, centerDotBrush);

    for (final item in toDoItems!) {
      drawToDoSegment(canvas, size, item);
    }
  }

  void drawToDoSegment(final Canvas canvas, final Size size, final ToDo item) {
    if (item.startTime == null || item.endTime == null) return;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min(centerX, centerY);

// Calculate start and end angles in radians
    final double startRad = ((item.startTime!.hour + 9) % 12) / 6 * pi;
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

    final segmentBrush = Paint()
      ..color = Colors.black.withAlpha(100)
      ..style = PaintingStyle.fill;

    final path = Path()
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
    final textPainter = TextPainter(
      text: TextSpan(
        text: item.title,
        style: const TextStyle(color: Colors.black, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final double labelAngle = startRad + (endRad - startRad) / 2;
    final labelOffset = Offset(
      center.dx + (radius - 60) * cos(labelAngle) - textPainter.width / 2,
      center.dy - (radius - 60) * sin(labelAngle) - textPainter.height / 2,
    );
    textPainter.paint(canvas, labelOffset);
  }

  @override
  bool shouldRepaint(covariant final CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
