import 'dart:async';

import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Models/get_trip_model.dart';
import 'package:bikerider/Models/timeLineModel.dart';
import 'package:bikerider/Screens/milestone_card.dart';
import 'package:bikerider/Utility/Secure_storeage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BikeState {}

class BikeInitialState extends BikeState {}

class BikeFirstLoginState extends BikeState {}

class BikeTimerState extends BikeState {
  int time;
  BikeTimerState(this.time);
}

class BikeFetchingState extends BikeState {}

class BikeProfileFetchedState extends BikeState {
  Map profile;
  BikeProfileFetchedState({required this.profile});
}

class BikeEmptyTripState extends BikeState {}

class BikeNonEmptyTripState extends BikeState {
  List<GetTripModel> getTripModel = [];
  BikeNonEmptyTripState(this.getTripModel);
}

class BikeAccFetchedState extends BikeState {
  List accessories;
  BikeAccFetchedState(this.accessories);
}

class BikeToolKitFetchedState extends BikeState {
  List toolKit;
  BikeToolKitFetchedState(this.toolKit);
}

class BikeAccEmptyFetchedState extends BikeState {}

class BikeTimerExpiredState extends BikeState {}

class BikeCubit extends Cubit<BikeState> {
  BikeCubit() : super(BikeInitialState());
  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }

  @override
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
    _timer = Timer.periodic(
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

  void getTrips() {
    emit(BikeFetchingState());
    UserSecureStorage.getToken().then((value) {
      UserHttp.getTrips(value!).then((value1) {
        if (value1.isEmpty) {
          emit(BikeEmptyTripState());
        } else {
          List<GetTripModel> temp = [];
          value1.forEach((element) {
            temp.add(GetTripModel.fromJson(element));
          });
          // value1.map((e) => temp.add(GetTripModel.fromJson(e)));
          emit(BikeNonEmptyTripState(temp));
        }
      });
    });
  }

  void getTripDetails() {
    emit(BikeFetchingState());
    UserSecureStorage.getToken().then((value) {
      UserHttp.getTripDetails(value!).then((value1) {
        if (value1.isEmpty) {
          emit(BikeEmptyTripState());
        } else {
          List<GetTripModel> temp = [];
          value1.forEach((element) {
            temp.add(GetTripModel.fromJson(element));
          });
          // value1.map((e) => temp.add(GetTripModel.fromJson(e)));
          emit(BikeNonEmptyTripState(temp));
        }
      });
    });
  }

  void getAcc(String item) {
    List accessories;
    emit(BikeFetchingState());
    UserHttp.getAccessories(item).then((value) {
      if (value.isEmpty) {
        emit(BikeAccEmptyFetchedState());
      } else {
        accessories = value;
        emit(BikeAccFetchedState(accessories));
      }
    });
  }

  void getToolKit(String item) {
    List toolKit;
    emit(BikeFetchingState());
    UserHttp.getToolKit(item).then((value) {
      if (value.isEmpty) {
        emit(BikeAccEmptyFetchedState());
      } else {
        toolKit = value;
        emit(BikeToolKitFetchedState(toolKit));
      }
    });
  }

  void getProfile() {
    print("emitted");
    emit(BikeFetchingState());
    UserSecureStorage.getToken().then((value) {
      UserHttp.getProfile(value!).then((value2) {
        emit(BikeProfileFetchedState(
          profile: value2,
        ));
      });
    });
  }
}
