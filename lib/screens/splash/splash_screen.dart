import 'dart:async';
import 'package:flutter/material.dart';
import '../../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // A Timer instance to manage the splash screen duration.
  Timer? _timer;
  // State variable to hold the countdown value.
  int _countdown = 5;

  // This method navigates to the main page and ensures the timer is cancelled
  // to prevent it from running in the background.
  void _navigateToMain() {
    _timer?.cancel();
    Navigator.pushReplacementNamed(context, AppRoutes.main);
  }

  @override
  void initState() {
    super.initState();
    // Start a periodic timer that ticks every second.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        // Decrease the countdown value and update the UI.
        setState(() {
          _countdown--;
        });
      } else {
        // When the countdown reaches 0, cancel the timer and navigate.
        _navigateToMain();
      }
    });
  }

  @override
  void dispose() {
    // It's crucial to cancel the timer when the widget is disposed to prevent
    // memory leaks and unexpected behavior.
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Text(
              "Welcome to E-Shop",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // Positioned the skip button at the top-right corner.
          Positioned(
            top: 20,
            right: 20,
            child: TextButton(
              onPressed: _navigateToMain,
              child: Text(
                "Skip(${_countdown})",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
