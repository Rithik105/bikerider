import 'package:bikerider/Screens/MyProfileScreen.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BikeCubit.dart';

class ProfileInter extends StatelessWidget {
  const ProfileInter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BikeCubit()..getMyProfile(),
      child: ProfileHeader(),
    );
  }
}
