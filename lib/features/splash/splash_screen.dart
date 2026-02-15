import 'dart:async';
import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800), // Fast fade-in
      vsync: this,
    );
    // Start with 0.0 (transparent) to fade in from white
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();

    Timer(const Duration(milliseconds: 4000),
        () { // Longer duration for second screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background as requested
      body: Stack(
        children: [
          // Center: Logo (Matches native splash position)
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                'assets/images/logo.png',
                width: 150, // Matches native splash size if configured
                height: 150,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.timer_outlined,
                    size: 100,
                    color: Colors.black,
                  ); 
                },
              ),
            ),
          ),
          
          // Bottom: Branding Text
          Positioned(
            left: 0,
            right: 0,
            bottom: 80, 
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "from",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "YALCIN STUDIO",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3.0,
                      fontFamily: 'Manrope',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
