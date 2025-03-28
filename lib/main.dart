import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gvagoo1/home.dart';
import 'package:gvagoo1/splash_screen.dart';
import 'package:gvagoo1/Onboarding/onboarding_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // ✅ Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gvagoo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // ✅ SplashScreen decides the initial route based on onboarding status
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const Login(),
        '/onboarding': (context) => const OnboardingView(),
        '/home': (context) => const Home(),
      },
    );
  }
}
