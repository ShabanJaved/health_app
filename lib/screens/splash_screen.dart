import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5), 
      () => Navigator.pushReplacementNamed(context, "/home"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 64, 64, 64),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 250,
          child: LottieBuilder.asset("assets/animation.json"),
        ),
      ),
    );
  }
}
