import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kelompok6_a22/util/theme.dart';
import 'package:kelompok6_a22/util/images.dart';
import 'package:kelompok6_a22/screen/welcome_screen/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    // Cancel the timer if the widget is being disposed
    _cancelTimer();
  }

  Timer? _timer;

  void startTimer() {
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // Check if the widget is still mounted before navigating
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => const WelcomeScreen(),
          ),
        );
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1Color,
      body: Center(
        child: Image.asset(Images.logoo),
      ),
    );
  }
}
