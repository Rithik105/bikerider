import 'package:bikerider/Screens/ForgotScreen.dart';
import 'package:bikerider/Screens/GetStartedScreen.dart';
import 'package:bikerider/Screens/LoginScreen.dart';
import 'package:bikerider/Screens/OtpScreen.dart';
import 'package:bikerider/Screens/OwnBikeScreen.dart';
import 'package:bikerider/Screens/RegisterScreen.dart';
import 'package:bikerider/Screens/SuccessPage.dart';
import 'package:bikerider/Utility/PageTransition.dart';
import 'package:flutter/material.dart';

import '../Screens/ChooseAvatarScreen.dart';
import '../Screens/HomePage.dart';
import '../Screens/SplashScreen.dart';
import '../Screens/Tutorial.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/Splash":
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case "/Tutorial":
        return LeftTransitions(child: Tutorial());
      case "/OtpScreen":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return LeftTransitions(
            child: OtpPage(
          mobile: arguments["mobile"],
        ));
      case "/ResetScreen":
        return MaterialPageRoute(builder: (context) => ResetPage());
      case "/SuccessScreen":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return LeftTransitions(
            child: SuccessPage(
          title: arguments["title"],
        ));

      case "/LoginScreen":
        return LeftTransitions(child: LoginScreen());
      case "/OwnBikeScreen":
        return LeftTransitions(child: OwnBikeScreen());
      case "/RegisterScreen":
        return LeftTransitions(child: RegisterScreen());
      case "/HomeScreen":
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case "/ChooseAvatarScreen":
        return LeftTransitions(child: ChooseAvatarScreen());
      case "/GetStartedScreen":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => GetStartedScreen(
                  storeImage: arguments["storeImage"],
                ));
    }
  }
}
