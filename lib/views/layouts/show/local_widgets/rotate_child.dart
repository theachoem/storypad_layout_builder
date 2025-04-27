import 'dart:math';
import 'package:flutter/material.dart';

class RotateChild extends StatelessWidget {
  const RotateChild({
    super.key,
    required this.child,
    required this.rotationDegree,
  });

  final Widget child;
  final double rotationDegree;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotationDegree * pi / 180,
      child: child,
    );
  }
}
