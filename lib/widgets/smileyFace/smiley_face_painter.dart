import 'dart:math';

import 'package:flutter/material.dart';

class SmileyFacePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // choose minimum value to derive radius
    final radius = min(size.width, size.height) / 2;

    // center the widget based on the size of the screen
    final center = Offset(size.width / 2, size.height / 2);

    // draw the body
    final paint = Paint()..color = Colors.yellow;

    canvas.drawCircle(center, radius, paint);

    // draw the mouth
    final smilePaint = Paint()
      ..strokeJoin = StrokeJoin.round // round edges for joined strokes
      ..style = PaintingStyle.stroke // unfilled stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round; // round the edges

    final smileRect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 1.825),
      radius: radius / 2,
    );

    canvas.drawArc(
      smileRect,
      0,
      pi, // pi represents half a circle or 180 degrees
      true, // to connect arc or not to connect arc
      smilePaint,
    );

    // Draw the eyes

    // positioning

    //   - (center.dx - radius) will move the widget being painted to the far left edge of a circle, the inverse is also true

    //   - (center.dy - radius) will move the widget being painted to the top edge of a circle, the inverse is also true

    const eyePosition = 2.75;

    const eyeSize = 20.0;

    void leftEye() => canvas.drawCircle(
          Offset(center.dx - radius / eyePosition, center.dy - radius / eyePosition),
          eyeSize,
          Paint(),
        );

    void rightEye() => canvas.drawCircle(
          Offset(center.dx + radius / eyePosition, center.dy - radius / eyePosition),
          eyeSize,
          Paint(),
        );

    leftEye.call();

    rightEye.call();
  }

  @override
  bool shouldRepaint(SmileyFacePainter oldDelegate) => false;
}


// CustomPaint

//   - a widget that provides you with a canvas

//   - uses a CustomPainter to execute paint commands

// CustomPainter

//   - the class responsible for painting

//   - paint function

//       - where the drawing occurs

//       - has two parameters: canvas and size

//   - shouldRepaint function

//       - controls when the painter should redraw

//       - if there are no mutable properties shouldRepaint should return false

// Painting on The Canvas

//   - each time you paint on the canvas you need to pass a paint object