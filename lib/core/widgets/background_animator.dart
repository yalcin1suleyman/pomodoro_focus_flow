import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/settings/settings_provider.dart';
import '../../features/timer/timer_service.dart';
import '../../core/theme/app_theme.dart';

class BackgroundAnimator extends StatefulWidget {
  final Widget child;
  const BackgroundAnimator({super.key, required this.child});

  @override
  State<BackgroundAnimator> createState() => _BackgroundAnimatorState();
}

class _BackgroundAnimatorState extends State<BackgroundAnimator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    // Default duration slow, speed up logic handles the rest
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
    _initParticles();
  }

  void _initParticles() {
    _particles.clear();
    for (int i = 0; i < 30; i++) {
      _particles.add(_createParticle());
    }
  }

  _Particle _createParticle() {
    return _Particle(
      x: _random.nextDouble(),
      y: _random.nextDouble(),
      speed: _random.nextDouble() * 0.2 + 0.05,
      size: _random.nextDouble() * 15 + 5,
      angle: _random.nextDouble() * 2 * pi,
      rotationSpeed: _random.nextDouble() * 0.1 - 0.05,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to TimerService to determine animation state
    final isTimerRunning = context.select<TimerService, bool>((service) => service.status == TimerStatus.running);
    
    // Adjust animation speed based on timer state
    if (isTimerRunning) {
       if (_controller.duration != const Duration(seconds: 5)) {
         _controller.duration = const Duration(seconds: 5); // Faster when focused
         _controller.repeat();
       }
    } else {
       if (_controller.duration != const Duration(seconds: 60)) {
         _controller.duration = const Duration(seconds: 60); // Very slow drift when idle
         _controller.repeat();
       }
    }

    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        if (settings.currentTheme == AppThemeType.defaultTheme) {
          return widget.child;
        }

        return Stack(
          children: [
            // Animated Background Layer
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return CustomPaint(
                  painter: _ParticlePainter(
                    particles: _particles,
                    theme: settings.currentTheme,
                    progress: _controller.value,
                    colorScheme: Theme.of(context).colorScheme,
                    isActive: isTimerRunning,
                  ),
                  size: Size.infinite,
                );
              },
            ),
            widget.child,
          ],
        );
      },
    );
  }
}

class _Particle {
  double x;
  double y;
  double speed;
  double size;
  double angle;
  double rotationSpeed;

  _Particle({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.angle,
    required this.rotationSpeed,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final AppThemeType theme;
  final double progress;
  final ColorScheme colorScheme;
  final bool isActive;

  _ParticlePainter({
    required this.particles,
    required this.theme,
    required this.progress,
    required this.colorScheme,
    required this.isActive,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Animation factor: if IDLE, particles move extremely slowly
    double speedFactor = isActive ? 1.0 : 0.05;

    for (var particle in particles) {
      // Update position
      particle.y += particle.speed * 0.01 * speedFactor; 
      particle.angle += particle.rotationSpeed * speedFactor;
      
      // Reset if out of bounds
      if (particle.y > 1.2) {
        particle.y = -0.2;
        particle.x = Random().nextDouble();
      }

      final dx = particle.x * size.width;
      final dy = particle.y * size.height;
      
      paint.color = _getParticleColor(theme).withOpacity(isActive ? 0.6 : 0.3); // Fade out when idle

      canvas.save();
      canvas.translate(dx, dy);
      canvas.rotate(particle.angle);

      if (theme == AppThemeType.sakura) {
        // Draw Petal (Oval shape)
        canvas.drawOval(
           Rect.fromCenter(center: Offset.zero, width: particle.size, height: particle.size * 0.6),
           paint,
        );
      } else if (theme == AppThemeType.space) {
        // Draw Star (Circle for simplicity, or small diamond)
        paint.color = Colors.white.withOpacity((Random().nextDouble() * 0.5 + 0.2) * (isActive ? 1.0 : 0.5));
        canvas.drawCircle(Offset.zero, particle.size * 0.1, paint);
      } else if (theme == AppThemeType.ocean) {
        // Draw Bubble
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = 1.5;
        canvas.drawCircle(Offset.zero, particle.size * 0.4, paint);
      } else {
         // Forest / Leaf
        canvas.drawRect(
           Rect.fromCenter(center: Offset.zero, width: particle.size * 0.5, height: particle.size * 0.5),
           paint,
        );
      }

      canvas.restore();
    }
  }

  Color _getParticleColor(AppThemeType type) {
    switch (type) {
      case AppThemeType.sakura:
        return const Color(0xFFFFB7B2);
      case AppThemeType.ocean:
        return Colors.white;
      case AppThemeType.forest:
        return const Color(0xFFD8F3DC);
      case AppThemeType.space:
        return Colors.white;
      default:
        return Colors.grey;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
