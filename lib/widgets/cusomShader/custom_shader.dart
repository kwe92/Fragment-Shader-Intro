import 'dart:ui';

import 'package:custom_shaders/common/reactive_widget.dart';
import 'package:custom_shaders/widgets/cusomShader/custom_shader_painter.dart';
import 'package:flutter/material.dart';

class CustomShader extends StatelessWidget {
  final Color color;
  final FragmentShader shader;

  const CustomShader(this.color, {required this.shader, super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveWidget(
      builder: (context, time, size) {
        // final ticker = TickingBuilder.of(context);

        // ticker?.ticker.stop();

        // print(ticker?.ticker);

        return CustomPaint(
          painter: CustomShaderPainter(
            Colors.orange,
            shader: shader,
            time: time,
          ),
        );
      },
    );
  }
}
