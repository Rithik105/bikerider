import 'package:bikerider/Screens/AccesoriesScreen.dart';
import 'package:bikerider/Screens/ForgotScreen.dart';
import 'package:bikerider/Screens/GetStartedScreen.dart';
import 'package:bikerider/Screens/LoginScreen.dart';
import 'package:bikerider/Screens/OtpRegisterScreen.dart';
import 'package:bikerider/Screens/OwnBikeScreen.dart';
import 'package:bikerider/Screens/RegisterScreen.dart';
import 'package:bikerider/Screens/SuccessPage.dart';
import 'package:bikerider/Screens/create_trip.dart';
import 'package:bikerider/Screens/invite_people.dart';
import 'package:bikerider/Screens/trip_summary_create.dart';
import 'package:bikerider/Screens/trip_summary_go.dart';
import 'package:bikerider/Utility/PageTransition.dart';
import 'package:bikerider/custom/widgets/CustomCard.dart';
import 'package:flutter/material.dart';

import '../Screens/ChooseAvatarScreen.dart';
import '../Screens/HomePage.dart';
import '../Screens/OtpForgotScreen.dart';
import '../Screens/SplashScreen.dart';
import '../Screens/Tutorial.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/Splash":
        return MaterialPageRoute(builder: (context) => SplashScreen());
      //---------------------------------------------------------
      case "/ForgotScreen":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
            builder: (context) => ForgotScreen(
                  mobile: arguments["mobile"],
                ));
      //---------------------------------------------------------
      case "/InvitePage":
        return LeftTransitions(child: InvitePage());

      //---------------------------------------------------------
      case "/Tutorial":
        return LeftTransitions(child: Tutorial());
      //---------------------------------------------------------
      case "/OtpRegisterScreen":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return LeftTransitions(
            child: OtpRegisterScreen(
          user: arguments["User"],
        ));
      //---------------------------------------------------------
      case "/OtpForgotScreen":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return LeftTransitions(
            child: OtpForgotScreen(
          mobile: arguments["mobile"],
        ));
      //---------------------------------------------------------
      case "/TripSummaryGo":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return LeftTransitions(
            child: TripSummaryGo(
          getTripModel: arguments["getTripModel"],
        ));
      //---------------------------------------------------------
      case "/CreateTrip":
        return LeftTransitions(child: CreateTrip());
      //---------------------------------------------------------
      case "/SuccessScreen":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return LeftTransitions(
            child: SuccessPage(
          title: arguments["title"],
          nextScreen: arguments["nextScreen"],
        ));
      //---------------------------------------------------------
      case "/LoginScreen":
        return LeftTransitions(child: LoginScreen());
      //---------------------------------------------------------
      case "/AccessoriesScreen":
        return LeftTransitions(child: AccessoriesScreen());
      //---------------------------------------------------------
      case "/OwnBikeScreen":
        return LeftTransitions(child: OwnBikeScreen());
      //---------------------------------------------------------
      case "/RegisterScreen":
        return LeftTransitions(child: RegisterScreen());
      //---------------------------------------------------------
      case "/HomeScreen":
        return MaterialPageRoute(builder: (context) => HomeScreen());
      //---------------------------------------------------------
      case "/ChooseAvatarScreen":
        return LeftTransitions(child: ChooseAvatarScreen());
      //---------------------------------------------------------
      case "/GetStartedScreen":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => GetStartedScreen(
                  storeImage: arguments["storeImage"],
                ));
      //---------------------------------------------------------
      case "/TripSummaryCreate":
        return LeftTransitions(child: TripSummaryCreate());
    }
  }
}
