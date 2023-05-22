import 'package:flutter/material.dart';

class DottedLine extends CustomPainter {
  final Color color;
  final double lineThickness;
  final List<double> dashArray;

  DottedLine({
    required this.color,
    required this.lineThickness,
    required this.dashArray,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = lineThickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path();
    double dashWidth = dashArray.fold(0, (prev, element) => prev + element);

    double dx = 0;
    while (dx < size.width) {
      for (final dash in dashArray) {
        if (dx + dash >= size.width) {
          path.moveTo(dx, size.height / 2);
          path.lineTo(size.width, size.height / 2);
          break;
        }
        path.moveTo(dx, size.height / 2);
        path.lineTo(dx + dash, size.height / 2);
        dx += dash;
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(DottedLine oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.lineThickness != lineThickness ||
        oldDelegate.dashArray != dashArray;
  }
}
