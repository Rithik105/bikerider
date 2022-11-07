import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bikerider/Screens/LoginScreen.dart';
import 'package:bikerider/Screens/Tutorial.dart';
import 'package:bikerider/bloc/BikeCubit.dart';
import 'package:bikerider/custom/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    _loadFirst().then((value) {
      if (value) {
        BlocProvider.of<BikeCubit>(context).firtsLogin();
      } else {
        BlocProvider.of<BikeCubit>(context).emit(BikeInitialState());
      }
    });
  }

  Future<bool> _loadFirst() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getBool("firstLogin") ?? true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BikeCubit, BikeState>(
      builder: (context, state) {
        if (state is BikeFirstLoginState) {
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
        } else {
          return Container(
            decoration: kSplashScreenDecoration,
            child: AnimatedSplashScreen(
              duration: 4000,
              splash: "assets/images/splash/splash.png",
              splashIconSize: 250,
              backgroundColor: Colors.transparent,
              nextScreen: LoginScreen(),
            ),
          );
        }
      },
    );
  }
}
