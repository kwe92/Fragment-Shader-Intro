import 'dart:ui';

import 'package:flutter/material.dart';

class CustomShaderPainter extends CustomPainter {
  final Color color;

  FragmentShader shader;

  final double time;

  CustomShaderPainter(
    this.color, {
    required this.shader,
    required this.time,
  });

  @override
  void paint(Canvas canvas, Size size) {
    shader = _setSize(shader, size);

    shader.setFloat(2, time);

    final paint = Paint()..shader = shader;

    // ..shader = _setColor(
    //   shader,
    //   color,
    //   indexStart: 0,
    // );

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomShaderPainter oldDelegate) => oldDelegate.color != color;
}

FragmentShader _setColor(FragmentShader shader, Color color, {required int indexStart}) {
  final colorValues = _normalizeColorValues(color);

  for (var i = 0; i < 4; i++) {
    shader.setFloat(i + indexStart, colorValues[i]);
  }

  return shader;
}

List<double> _normalizeColorValues(Color color) {
  final red = color.red.toDouble() / 255;

  final green = color.green.toDouble() / 255;

  final blue = color.blue.toDouble() / 255;

  final alpha = color.alpha.toDouble() / 255;

  final normalizedColorValues = [red, green, blue, alpha];

  return normalizedColorValues;
}

FragmentShader _setSize(FragmentShader shader, Size size) {
  shader.setFloat(0, size.width);

  shader.setFloat(1, size.height);

  return shader;
}
