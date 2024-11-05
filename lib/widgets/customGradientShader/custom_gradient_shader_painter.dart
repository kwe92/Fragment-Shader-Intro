import 'dart:ui';

import 'package:flutter/material.dart';

class CustomGradientShaderPainter extends CustomPainter {
  // the color that will be passed to the shader
  final Color startColor;

  final Color endColor;

  final FragmentShader shader;

  const CustomGradientShaderPainter(
    this.startColor,
    this.endColor, {
    required this.shader,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // passing arguments to a fragment shader by using the FragmentShader API
    // set methods, must look at what uniform variables the shader expects

    // in our example the shader expect 6 floating point values starting with a 0-based index
    // which represents a vector-2d (size) and a vector4d (color in RGBA)

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

    // gradient spread
    shader.setFloat(10, 1.25);

    // define a rectangle that fills all available space, with a suplied paint object
    // add shader to Paint object directly using cascade
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  // if properties change and do not match previous widget repaint
  @override
  bool shouldRepaint(CustomGradientShaderPainter oldDelegate) => startColor != oldDelegate.startColor || endColor != oldDelegate.endColor;
}


// Passing Color Values to Shader

//   - in GLSL floats for some data types should be normalized between 0 and 1

//   - in GLSL colors are represented as vectors of length four (red, green, blue, alpha)
//     with values ranging between 0 and 1

//   - to convert a number to its normailzed form divide the result bythe maximum value

//   - RBGA has a color value between 0-255 so you must divide each value by 255 to normailize
