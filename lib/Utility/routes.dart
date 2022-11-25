import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bikerider/Screens/AccesoriesScreen.dart';
import 'package:bikerider/Screens/choose_avatar_screen.dart';
import 'package:bikerider/Screens/forgot_screen.dart';
import 'package:bikerider/Screens/get_started_screen.dart';
import 'package:bikerider/Screens/home_screen.dart';
import 'package:bikerider/Screens/login_screen.dart';
import 'package:bikerider/Screens/otp_forgot_screen.dart';
import 'package:bikerider/Screens/otp_registration_screen.dart';
import 'package:bikerider/Screens/own_bike_screen.dart';
import 'package:bikerider/Screens/register_screen.dart';
import 'package:bikerider/Screens/splash_screen.dart';
import 'package:bikerider/Screens/SuccessPage.dart';
import 'package:bikerider/Screens/tutorial_screen.dart';
import 'package:bikerider/Screens/create_trip_screen.dart';
import 'package:bikerider/Screens/invite_screen.dart';
import 'package:bikerider/Screens/took_kit_screen.dart';
import 'package:bikerider/Screens/trip_summary_create.dart';
import 'package:bikerider/Screens/trip_summary_go.dart';
import 'package:bikerider/Utility/PageTransition.dart';
import 'package:bikerider/bloc/BikeCubit.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      //---------------------------------------------------------
      case "/Splash":
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => BikeCubit()..checkLogin(),
                  child: SplashScreen(),
                ));
      //---------------------------------------------------------
      case "/Tutorial":
        return LeftTransitions(child: TutorialScreen());
      //---------------------------------------------------------
      case "/OwnBikeScreen":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return LeftTransitions(
            child: OwnBikeScreen(
          user: arguments["User"],
        ));
      //---------------------------------------------------------
      case "/LoginScreen":
        return LeftTransitions(child: LoginScreen());
      //---------------------------------------------------------
      case "/OtpForgotScreen":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return LeftTransitions(
            child: OtpForgotScreen(
          mobile: arguments["mobile"],
        ));
      //---------------------------------------------------------
      case "/ForgotScreen":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => ForgotScreen(
                  mobile: arguments["mobile"],
                ));
      //---------------------------------------------------------
      case "/RegisterScreen":
        return LeftTransitions(child: RegisterScreen());
      //---------------------------------------------------------
      case "/OtpRegisterScreen":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return LeftTransitions(
            child: OtpRegisterScreen(
                user: arguments["User"], own: arguments["OwnBike"]));

      //---------------------------------------------------------
      case "/ChooseAvatarScreen":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return LeftTransitions(
            child: ChooseAvatarScreen(
          name: arguments["name"],
        ));
      //---------------------------------------------------------
      case "/GetStartedScreen":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => GetStartedScreen(
                  storeImage: arguments["storeImage"],
                ));
      //---------------------------------------------------------
      case "/HomeScreen":
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => BikeCubit()..getTrips(),
                  child: HomeScreen(),
                ));
      //---------------------------------------------------------
      case "/CreateTrip":
        return LeftTransitions(child: const CreateTripScreen());
      //---------------------------------------------------------

      case "/InvitePage":
        return LeftTransitions(child: const InviteScreen());

      //---------------------------------------------------------
      case "/TripSummaryGo":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return LeftTransitions(
            child: TripSummaryGo(
          getTripModel: arguments["getTripModel"],
        ));

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
      case "/AccessoriesScreen":
        return LeftTransitions(
            child: BlocProvider(
          create: (context) => BikeCubit()..getAcc(""),
          child: const AccessoriesScreen(),
        ));

      //---------------------------------------------------------
      case "/TripSummaryCreate":
        return LeftTransitions(child: TripSummaryCreateScreen());
      //---------------------------------------------------------
      //---------------------------------------------------------
      case "/ToolKitScreen":
        return LeftTransitions(
            child: BlocProvider(
          create: (context) => BikeCubit()..getToolKit(""),
          child: const ToolKitScreen(),
        ));
    }
    return null;
  }
}
