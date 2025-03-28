import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gvagoo1/home.dart';
import 'package:gvagoo1/Onboarding/onboarding_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _navigateAfterDelay();
  }

  // ✅ Initialize animation controller
  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // ✅ Scale animation (0.8x to 1.2x)
    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward(); // Start animation
  }

  // ✅ Check onboarding status and navigate
  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2)); // Wait for splash animation

    final bool showHome = await _checkOnboardingStatus();
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => showHome ? const Home() : const OnboardingView(),
      ),
    );
  }

  // ✅ Check if onboarding is completed
  Future<bool> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("onboarding") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Text(
            'Gvagoo',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // ✅ Dispose to avoid memory leaks
    super.dispose();
  }
}
