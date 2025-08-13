import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialDeciderScreen extends StatefulWidget {
  const InitialDeciderScreen({super.key});

  @override
  State<InitialDeciderScreen> createState() => _InitialDeciderScreenState();
}

class _InitialDeciderScreenState extends State<InitialDeciderScreen> {
  @override
  void initState() {
    super.initState();
    _decideInitialRoute();
  }

  Future<void> _decideInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();

    final hasSeenOnboarding = prefs.getBool('onboarding_seen') ?? false;
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    final isProfileCompleted = prefs.getBool('is_profile_completed') ?? false;

    if (!mounted) return;

    if (!hasSeenOnboarding) {
      Navigator.pushReplacementNamed(context, '/onboarding');
      return;

    } else if (!isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/login');
      return;

    } else if (!isProfileCompleted) {
      Navigator.pushReplacementNamed(context, '/completeProfile');
      return;
    } else {
      Navigator.pushReplacementNamed(context, '/mainScreen');
      return;

    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

