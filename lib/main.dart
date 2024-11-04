import 'dart:ui';

import 'package:flutter/material.dart';

late FragmentProgram fragmentProgram;

Future<void> main() async {
  // create a FragmentProgram from defined GLSL shader
  fragmentProgram = await FragmentProgram.fromAsset('assets/shaders/my_shader.frag');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomPaint(
        painter: MyPainter(
          Colors.purple,
          //supply compiled shader to CustomPaint widget
          shader: fragmentProgram.fragmentShader(),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  // the color that will be passed to the shader
  final Color color;

  final FragmentShader shader;

  MyPainter(this.color, {required this.shader});

  @override
  void paint(Canvas canvas, Size size) {
    // passing arguments to a fragment shader but using the FragmentShader API
    // must look at what uniform variables the shader expects

    // in our example the shader expect 6 floating point values starting with a 0-based index
    // which represents a vector-2d (size) and a vector4d (color in RGBA)

    // shader.setFloat(0, size.width);
    // shader.setFloat(1, size.height);
    shader.setFloat(0, (color.red.toDouble() / 255));
    shader.setFloat(1, color.green.toDouble() / 255);
    shader.setFloat(2, color.blue.toDouble() / 255);
    shader.setFloat(3, color.alpha.toDouble() / 255);

    // define a rectangle that fills all available space, with a suplied paint object
    // add shader to Paint object directly using cascade
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  // if properties change and do not match previous widget repaint
  @override
  bool shouldRepaint(MyPainter oldDelegate) => color != oldDelegate.color;
}
