import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bikerider/Screens/Tutorial.dart';
import 'package:bikerider/custom/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool firstLogin = true;
  @override
  void initState() {
    super.initState();
    _loadFirst();
    Timer(const Duration(seconds: 3), () {
      if (firstLogin) {
        Navigator.pushReplacementNamed(context, "/Tutorial");
      } else {
        Navigator.pushReplacementNamed(context, "/LoginScreen");
      }
    });
  }

  void _loadFirst() async {
    final prefs = await SharedPreferences.getInstance();
    firstLogin = (prefs.getBool("firstLogin") ?? true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kSplashScreenDecoration,
      child: AnimatedSplashScreen(
        duration: 4000,
        splash: "assets/images/splash/splash.png",
        splashIconSize: 250,
        backgroundColor: Colors.transparent,
        nextScreen: Tutorial(),
      ),
    );
  }
}
