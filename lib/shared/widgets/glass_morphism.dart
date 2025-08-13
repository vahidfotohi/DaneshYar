import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  final Widget child;
  final double blur;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;

  const GlassMorphism({
    super.key,
    required this.child,
    this.blur = 10.0,
    this.borderRadius = 20.0,
    this.borderColor = Colors.white70,
    this.backgroundColor = Colors.white10,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor.withValues(alpha: 0.2)),
          ),
          child: child,
        ),
      ),
    );
  }
}
