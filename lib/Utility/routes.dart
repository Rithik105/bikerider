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
        return MaterialPageRoute(builder: (context) => Tutorial());
      case "/OtpScreen":
        return MaterialPageRoute(builder: (context) => OtpPage());
      case "/ResetScreen":
        return MaterialPageRoute(builder: (context) => ResetPage());
      case "/SuccessScreen":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => SuccessPage(
                  title: arguments["title"],
                ));

      case "/LoginScreen":
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case "/OwnBikeScreen":
        return MaterialPageRoute(builder: (context) => OwnBikeScreen());
      case "/RegisterScreen":
        return MaterialPageRoute(builder: (context) => RegisterScreen());
      case "/HomeScreen":
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case "/ChooseAvatarScreen":
        return MaterialPageRoute(builder: (context) => ChooseAvatarScreen());
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
