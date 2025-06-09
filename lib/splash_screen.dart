import 'dart:async';

import 'package:flutter/material.dart';
import 'package:predicts_diabetes/Views/auth.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  _navigateToNextScreen(BuildContext context) {
    Future.microtask(() async {
      /// Check IF user seen the onboarding Screen Before Or Not
      // bool onboardingSeen = CacheService.instance.getData(key: 'seen') ?? false;

      /// Delaying for Splash Screen Content to displayed
      await Future.delayed(const Duration(seconds: 3));

      /// Navigation To onboarding ( if user didn't see it )
      /// Navigation To Login screen ( if User saw The onboarding Screen )
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AuthScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _navigateToNextScreen(context);

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Image.asset(
          "assets/splash.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
