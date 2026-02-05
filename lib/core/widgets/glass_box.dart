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
    this.blur = 10.0,
    this.opacity = 0.1,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = color ?? (isDark ? Colors.white : Colors.black);

    // Optimization: Skip BackdropFilter if blur is 0 (it's expensive)
    Widget content = Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: baseColor.withOpacity(opacity),
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        border: Border.all(
          color: baseColor.withOpacity(0.05),
          width: 1.5,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            baseColor.withOpacity(opacity + 0.05),
            baseColor.withOpacity(opacity),
          ],
        ),
      ),
      child: child,
    );

    if (blur <= 0) {
      return content;
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: content,
      ),
    );
  }
}
