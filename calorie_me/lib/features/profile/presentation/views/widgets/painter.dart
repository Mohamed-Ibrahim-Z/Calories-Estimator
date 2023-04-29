import 'package:calorie_me/core/constants/constants.dart';
import 'package:flutter/material.dart';

class profilePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = defaultColor;
    paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, size.height );
    path.quadraticBezierTo(size.width * 0.5, size.height *1.1, size.width, size.height );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // return true if you want to repaint the widget whenever the CustomPainter changes
    return false;
  }
}