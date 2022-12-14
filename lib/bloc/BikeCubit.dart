import 'dart:async';

import 'package:bikerider/Http/UserHttp.dart';
import 'package:bikerider/Models/get_trip_model.dart';
import 'package:bikerider/Providers/invite_provider.dart';
import 'package:bikerider/Utility/Secure_storeage.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BikeState {}

class BikeInitialState extends BikeState {} //

class BikeLoggedInState extends BikeState {} //

class BikeNoTripResultState extends BikeState {} //

class BikeLoggedOutState extends BikeState {} //

class BikeFirstLoginState extends BikeState {} //

class BikeTimerState extends BikeState {
  //
  int time;
  BikeTimerState(this.time);
}

class BikeContactSelectedState extends BikeState {}

class BikeContactNotSelectedState extends BikeState {}

class BikeTimerExpiredState extends BikeState {} //

class BikeGalleryFetchingState extends BikeState {}

class BikeGalleryFetchedState extends BikeState {}

class BikeFetchingState extends BikeState {}

class BikeMineProfileEditState extends BikeState {
  Map profile;

  BikeMineProfileEditState({required this.profile}) {}
}

class BikeMineProfileFetchedState extends BikeState {
  Map profile;
  BikeMineProfileFetchedState({required this.profile});
}

class BikeEmptyProfileFetchedState extends BikeState {
  BikeEmptyProfileFetchedState();
}

class BikeOtherProfileFetchedState extends BikeState {
  Map profile;
  String number;
  bool following;
  BikeOtherProfileFetchedState(
      {required this.profile, required this.number, required this.following});
}

class BikeEmptyTripState extends BikeState {}

class BikeNonEmptyTripState extends BikeState {
  List<GetTripModel> getTripModel = [];
  String myMobile;
  BikeNonEmptyTripState(this.getTripModel, this.myMobile);
}

class BikeAccFetchedState extends BikeState {
  Map accessories;
  BikeAccFetchedState(this.accessories);
}

class BikeToolKitFetchedState extends BikeState {
  List toolKit;
  BikeToolKitFetchedState(this.toolKit);
}

class BikeAccEmptyFetchedState extends BikeState {}

class BikeCubit extends Cubit<BikeState> {
  BikeCubit() : super(BikeInitialState());

  @override
  Timer? _timer;

  void checkLogin() {
    _loadFirst().then((value) {
      if (value) {
        emit(BikeFirstLoginState());
      } else {
        _loadLogin().then((value) {
          print(value);
          if (value) {
            UserSecureStorage.getToken().then((value1) {
              UserHttp.getTokenStart(value1!).then((value2) {
                if (value2["message"] == "refresh token expired") {
                  showToast(msg: "You have been logged out");
                  print("hiii");
                  emit(BikeLoggedOutState());
                } else {
                  UserSecureStorage.setToken(value2["access_token"]);
                  print(value2["access_token"]);
                  emit(BikeLoggedInState());
                }
              });
            });
          } else {
            emit(BikeLoggedOutState());
          }
        });
      }
    });
  }

  Future<bool> _loadFirst() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getBool("firstLogin") ?? true);
  }

  Future<bool> _loadLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getBool("loggedIn") ?? false);
  }

  void timer(int start) {
    if (_timer == null) {
    } else {
      _timer!.cancel();
    }
    emit(BikeTimerState(start));
    const oneSec = Duration(seconds: 1);
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
        print('myTrips' + value1.toString());
        if (value1!.isEmpty) {
          emit(BikeEmptyTripState());
        } else {
          List<GetTripModel> temp = [];
          value1.forEach((element) {
            temp.add(GetTripModel.fromJson(element));
          });
          UserSecureStorage.getDetails(key: "mobile").then((value) {
            print(value);
            emit(BikeNonEmptyTripState(temp, value!));
          });
        }
      });
    });
  }

  void getTripDetails() {
    emit(BikeFetchingState());
    UserSecureStorage.getToken().then((value) {
      UserHttp.getTripDetails(value!).then((value1) {
        if (value1!.isEmpty) {
          emit(BikeEmptyTripState());
        } else {
          List<GetTripModel> temp = [];
          value1.forEach((element) {
            temp.add(GetTripModel.fromJson(element));
          });
          // value1.map((e) => temp.add(GetTripModel.fromJson(e)));
          UserSecureStorage.getDetails(key: "mobile").then((value) {
            emit(BikeNonEmptyTripState(temp, value!));
          });
        }
      });
    });
  }

  void searchTrip(String trip) {
    emit(BikeFetchingState());
    UserSecureStorage.getToken().then((value) {
      UserHttp.searchTrips(trip, value!).then((value1) {
        if (value1!.isEmpty) {
          emit(BikeNoTripResultState());
        } else {
          List<GetTripModel> temp = [];
          value1.forEach((element) {
            temp.add(GetTripModel.fromJson(element));
          });
          UserSecureStorage.getDetails(key: "mobile").then((value) {
            emit(BikeNonEmptyTripState(temp, value!));
          });
        }
      });
    });
  }

  void searchTripDetails(String trip) {
    emit(BikeFetchingState());
    UserSecureStorage.getToken().then((value) {
      UserHttp.searchTripsDetails(trip, value!).then((value1) {
        if (value1!.isEmpty) {
          emit(BikeNoTripResultState());
        } else {
          List<GetTripModel> temp = [];
          value1.forEach((element) {
            temp.add(GetTripModel.fromJson(element));
          });
          UserSecureStorage.getDetails(key: "mobile").then((value) {
            emit(BikeNonEmptyTripState(temp, value!));
          });
        }
      });
    });
  }

  void getAcc(String item) {
    Map accessories;
    emit(BikeFetchingState());
    UserSecureStorage.getToken().then((value) {
      UserHttp.getAccessories(item, value!).then((value2) {
        if (value2!.isEmpty) {
          emit(BikeAccEmptyFetchedState());
        } else {
          accessories = value2;
          emit(BikeAccFetchedState(accessories));
        }
      });
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

  void getMyProfile() {
    UserSecureStorage.getDetails(key: "mobile").then(
      (value) => getProfile(value!),
    );
  }

  void getProfile(String number) {
    bool following = false;
    print("emitted");
    emit(BikeFetchingState());
    UserSecureStorage.getToken().then((value) {
      UserSecureStorage.getDetails(key: "mobile").then((value3) {
        UserHttp.getProfile(value!, number).then((value2) {
          print(value2);
          if (value2!["userDetails"] == null) {
            print('---------------------------');
            emit(BikeEmptyProfileFetchedState());
            showToast(msg: "User Not Registered");
          } else if (value3 == number) {
            emit(BikeMineProfileFetchedState(
              profile: value2!,
            ));
          } else {
            for (int i = 0;
                i < value2!["userDetails"]["followers"].length;
                i++) {
              if (value2["userDetails"]["followers"][i]["followerPhone"] ==
                  value3) {
                following = true;
                break;
              } else
                following = false;
            }
            emit(BikeOtherProfileFetchedState(
                profile: value2, number: number, following: following));
          }
        });
      });
    });
  }

  convertToPhoneNumber(Contact contact) {
    String number;
    number = contact.phones![0].value!.trim().replaceAll(' ', '');
    number = number.replaceAll('-', '');
    if (number[0] == "+") {
      return number.substring(1, 12);
    } else if (number.length == 10) {
      return number;
    } else {
      return number;
    }
  }
}
