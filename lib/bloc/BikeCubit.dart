import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BikeState {}

class BikeInitialState extends BikeState {}

class BikeFirstLoginState extends BikeState {}

class BikeTimerState extends BikeState {
  int time;
  BikeTimerState(this.time);
}

class BikeTimerExpiredState extends BikeState {}

class BikeCubit extends Cubit<BikeState> {
  BikeCubit() : super(BikeInitialState());
  void firtsLogin() {
    emit(BikeFirstLoginState());
  }

  Timer? _timer;

  void timer(int start) {
    if (_timer == null) {
    } else {
      _timer!.cancel();
    }
    emit(BikeTimerState(start));
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          emit(BikeTimerExpiredState());
          timer.cancel();
          _timer!.cancel();
        } else {
          start--;
          emit(BikeTimerState(start));
        }
      },
    );
  }
}
