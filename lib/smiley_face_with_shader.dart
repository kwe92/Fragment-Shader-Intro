import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class SmileyFaceWithShader extends StatelessWidget {
  final Color startColor;

  final Color endColor;

  final FragmentShader shader;

  const SmileyFaceWithShader(
    this.startColor,
    this.endColor, {
    required this.shader,
    super.key,
  });

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: SmileyFaceWithShaderPainter(
          Colors.orangeAccent,
          Colors.yellowAccent,
          shader: shader,
        ),
      );
}

class SmileyFaceWithShaderPainter extends CustomPainter {
  final Color startColor;

  final Color endColor;

  final FragmentShader shader;

  const SmileyFaceWithShaderPainter(
    this.startColor,
    this.endColor, {
    required this.shader,
  });
  @override
  void paint(Canvas canvas, Size size) {
    // Set Shader Properties

    // uSize
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);

    // uColor
    shader.setFloat(2, (startColor.red.toDouble() / 255));
    shader.setFloat(3, startColor.green.toDouble() / 255);
    shader.setFloat(4, startColor.blue.toDouble() / 255);
    shader.setFloat(5, startColor.alpha.toDouble() / 255);

    // gradientColor
    shader.setFloat(6, (endColor.red.toDouble() / 255));
    shader.setFloat(7, endColor.green.toDouble() / 255);
    shader.setFloat(8, endColor.blue.toDouble() / 255);
    shader.setFloat(9, endColor.alpha.toDouble() / 255);

    // TODO: could be its own property
    // gradient spread
    shader.setFloat(10, 1.3);

    // choose minimum value to derive radius
    final radius = min(size.width, size.height) / 2;

    // center the widget based on the size of the screen
    final center = Offset(size.width / 2, size.height / 2);

    // draw the body
    final paint = Paint()..shader = shader;

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
  bool shouldRepaint(SmileyFaceWithShaderPainter oldDelegate) => false;
}
