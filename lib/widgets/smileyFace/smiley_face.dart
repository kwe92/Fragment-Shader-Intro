import 'package:custom_shaders/widgets/smileyFace/smiley_face_painter.dart';
import 'package:flutter/material.dart';

class SmileyFace extends StatelessWidget {
  const SmileyFace({super.key});

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: SmileyFacePainter(),
      );
}
