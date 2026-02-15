import 'dart:ui';
import 'package:flutter/material.dart';

class GlassBox extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double blur;
  final double opacity;
  final Color? color;

  const GlassBox({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.padding,
    this.blur = 20.0, // Significant blur for readability
    this.opacity = 0.25, // Higher opacity to separate from background
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = color ?? (isDark ? Colors.black : Colors.white); // Darker base for dark mode

    // Optimization: Skip BackdropFilter if blur is 0 (it's expensive)
    Widget content = Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: baseColor.withValues(alpha: opacity),
        borderRadius: borderRadius ?? BorderRadius.circular(24), // Softer corners
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12), // Subtle but visible border
          width: 1.0, 
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            baseColor.withValues(alpha: opacity + 0.1), // Slightly lighter top-left
            baseColor.withValues(alpha: opacity),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: -5,
          )
        ]
      ),
      child: child,
    );

    if (blur <= 0) {
      return content;
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: content,
      ),
    );
  }
}
