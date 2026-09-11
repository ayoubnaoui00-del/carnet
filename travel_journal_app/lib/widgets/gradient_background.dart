import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  static const BoxDecoration decoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFFFFFFF), // Crisp Clean White
        Color(0xFFE0EEE6), // Soft Sage Morning
        Color(0xFFB2D5BF), // Rich Pine Mist
        Color(0xFF85B897), // Deep Nordic Moss Green
      ],
      stops: [0.0, 0.25, 0.65, 1.0],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: decoration,
      child: child,
    );
  }
}
