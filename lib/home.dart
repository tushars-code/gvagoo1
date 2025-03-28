import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser;

  // Sign out method with navigation after sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      // Navigate back to login screen after sign out
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login', // Route to go to after sign out
            (Route<dynamic> route) => false, // Remove all previous routes
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gvagoo"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => signOut(),
          ),
        ],
      ),
      body: Center(
        child: Text(
          user != null
              ? 'Welcome, ${user!.email}' // Display user email
              : 'No user signed in!',
          style: const TextStyle(fontSize: 18),
        ),
      ),
      // Floating button to log out
      floatingActionButton: FloatingActionButton(
        onPressed: () => signOut(),
        backgroundColor: Colors.red,
        child: const Icon(Icons.logout),
      ),
    );
  }
}
