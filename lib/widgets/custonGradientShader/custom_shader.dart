import 'dart:ui';

import 'package:custom_shaders/widgets/custonGradientShader/custom_gradient_shader.dart';
import 'package:flutter/material.dart';

class CustomGradientShader extends StatelessWidget {
  final Color startColor;

  final Color endColor;

  final FragmentShader shader;

  const CustomGradientShader(
    this.startColor,
    this.endColor, {
    required this.shader,
    super.key,
  });

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: CustomShaderPainter(
          startColor,
          endColor,
          shader: shader,
        ),
      );
}
