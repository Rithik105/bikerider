import 'package:bikerider/Providers/Data.dart';
import 'package:bikerider/Providers/VisibiltyProvider.dart';
import 'package:bikerider/Utility/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'Providers/OwnBikeProvider.dart';
import 'Providers/invite_provider.dart';
import 'Screens/maps_provider.dart';
import 'bloc/BikeCubit.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BikeCubit(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => VisibilityProvider(),
          ),
          ChangeNotifierProvider(create: (context) => InviteProvider()),
          ChangeNotifierProvider(create: (context) => MapProvider()),
          ChangeNotifierProvider(create: (context) => OwnBike()),
          ChangeNotifierProvider(create: (context) => UserData())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.onGenerateRoute,
          initialRoute: "/Splash",
        ),
      ),
    );
  }
}
