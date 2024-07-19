import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.pushReplacementNamed(context, "/home");
    },);
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          "assets/json/splash.json",
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
