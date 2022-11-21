import 'package:flutter/Material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bikerider/Screens/trip_card.dart';
import 'package:bikerider/bloc/BikeCubit.dart';

class TripintermediateCard extends StatelessWidget {
  const TripintermediateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BikeCubit()..getTrips(),
      child: TripCard(),
    );
  }
}
