import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'GradientType.dart';

class GradientText extends StatelessWidget {
  GradientType? gradientType;
  List<Color> colors;
  Widget? child;
  double radius;

  GradientText({
    super.key,
    this.gradientType,
    required this.colors,
    this.child,
    this.radius = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        switch (gradientType) {
          case GradientType.radial:
            return RadialGradient(
              colors: colors,
              radius: radius,
              center: Alignment.centerLeft,
            ).createShader(bounds);
          default:
            return LinearGradient(
              colors: colors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds);
        }
      },
      child: child,
    );
  }
}
