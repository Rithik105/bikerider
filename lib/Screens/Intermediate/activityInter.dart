import 'package:bikerider/Screens/ActivitiesCard.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BikeCubit.dart';

class ActivityInter extends StatelessWidget {
  const ActivityInter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BikeCubit()..getTripDetails(),
      child: ActivityCard(),
    );
  }
}
