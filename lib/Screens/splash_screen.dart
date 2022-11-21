// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, duplicate_ignore

import 'dart:async';

import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Screens/home_screen.dart';
import 'package:bikerider/Utility/Secure_storeage.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bikerider/Screens/login_screen.dart';
import 'package:bikerider/Screens/tutorial_screen.dart';
import 'package:bikerider/bloc/BikeCubit.dart';
import 'package:bikerider/custom/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool firstLogin = true;

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
              nextScreen: const TutorialScreen(),
            ),
          );
        } else if (state is BikeLoggedOutState) {
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
        } else if (state is BikeLoggedInState) {
          return Container(
            decoration: kSplashScreenDecoration,
            child: AnimatedSplashScreen(
              duration: 4000,
              splash: "assets/images/splash/splash.png",
              splashIconSize: 250,
              backgroundColor: Colors.transparent,
              nextScreen: const HomeScreen(),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
