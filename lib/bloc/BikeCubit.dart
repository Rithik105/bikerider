import 'dart:async';

import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Models/get_trip_model.dart';
import 'package:bikerider/Utility/Secure_storeage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BikeState {}

class BikeInitialState extends BikeState {}

class BikeFirstLoginState extends BikeState {}

class BikeTimerState extends BikeState {
  int time;
  BikeTimerState(this.time);
}

class BikeChatEmptyState extends BikeState {}

class BikeChatNonEmptyState extends BikeState {
  List<Map> chatList;
  BikeChatNonEmptyState(this.chatList);
}

class BikeChatFetchingState extends BikeState {}

class BikeTripFetchState extends BikeState {}

class BikeEmptyTripState extends BikeState {}

class BikeNonEmptyTripState extends BikeState {
  List<GetTripModel> getTripModel = [];
  BikeNonEmptyTripState(this.getTripModel);
}

class BikeTimerExpiredState extends BikeState {}

class BikeCubit extends Cubit<BikeState> {
  BikeCubit() : super(BikeInitialState());
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
    emit(BikeTripFetchState());
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

  void getFirstChat(String groupId) {
    emit(BikeChatFetchingState());
    UserSecureStorage.getToken().then((value) {
      print(value);
      Timer.periodic(Duration(seconds: 10), (timer) {
        UserHttp.getChats(groupId, value!).then((value1) {
          if (value1.isEmpty) {
            emit(BikeChatEmptyState());
          } else {
            List<Map> chatList = [];
            value1.forEach((element) {
              chatList.add({
                "sender": element["senderName"]!,
                "message": element["chat"]!
              });
              emit(BikeChatNonEmptyState(chatList));
            });
          }
        });
      });
    });
  }
}
