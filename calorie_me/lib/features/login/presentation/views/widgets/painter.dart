import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.black12;
    canvas.drawCircle(
      Offset(size.width, 0),
      0.3 * size.width,
      paint,
    );
    canvas.drawCircle(Offset(0, size.height), 0.3 * size.width, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
