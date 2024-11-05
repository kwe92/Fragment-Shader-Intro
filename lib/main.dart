import 'dart:ui';

import 'package:custom_shaders/smiley_face_with_shader.dart';
import 'package:custom_shaders/widgets/cusomShader/custom_shader.dart';
import 'package:custom_shaders/widgets/customGradientShader/custom_shader.dart';
import 'package:flutter/material.dart';

late FragmentProgram fragmentProgram;

late FragmentProgram customFragmentProgram;

Future<void> main() async {
  // create a FragmentProgram from defined GLSL shader
  fragmentProgram = await FragmentProgram.fromAsset('assets/shaders/gradient_shader.frag');
  customFragmentProgram = await FragmentProgram.fromAsset('assets/shaders/custom_shader.frag');

  // runApp(const MainApp());

  runApp(const SecondaryApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: CustomGradientShader(
                Colors.purpleAccent,
                Colors.blueAccent,
                shader: fragmentProgram.fragmentShader(),
              ),
            ),
            Positioned.fill(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                width: 100,
                height: 100,
                child: SmileyFaceWithShader(
                  Colors.purpleAccent,
                  Colors.blueAccent,
                  shader: fragmentProgram.fragmentShader(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondaryApp extends StatelessWidget {
  const SecondaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShader(
      Colors.purple,
      shader: customFragmentProgram.fragmentShader(),
    );
  }
}
