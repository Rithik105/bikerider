import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BikeState {}

class BikeInitialState extends BikeState {}

class BikeFirstLoginState extends BikeState {}

class BikeCubit extends Cubit<BikeState> {
  BikeCubit() : super(BikeInitialState());
  void firtsLogin() {
    emit(BikeFirstLoginState());
  }
}
