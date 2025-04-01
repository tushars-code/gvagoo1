import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gvagoo1/home.dart';
import 'package:gvagoo1/signup.dart';
import 'package:gvagoo1/splash_screen.dart';
import 'package:gvagoo1/Onboarding/onboarding_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'get_started.dart';
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
        primarySwatch: Colors.blue,
      ),

      home: const SplashScreen(),
      routes: {
        '/login': (context) => const Login(), // ✅ Correct
        '/home': (context) => const Home(),   // ✅ Correct
        '/signup': (context) => const SignUpScreen(),
        '/onboarding': (context) => const OnboardingView(),
        '/welcome': (context) => const WelcomeScreen(),
      },
    );
  }
}

