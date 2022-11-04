import 'package:bikerider/Providers/VisibiltyProvider.dart';
import 'package:bikerider/Utility/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Providers/OwnBikeProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VisibilityProvider(),
        ),
        ChangeNotifierProvider(create: (context) => OwnBike())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: "/Splash",
      ),
    );
  }
}
