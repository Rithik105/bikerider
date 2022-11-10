import 'package:flutter/material.dart';

import '../Models/UserModel.dart';

class UserData extends ChangeNotifier {
  User? user;
  String? token;
  void setUserData(User tempuser) {
    user = tempuser;
    notifyListeners();
  }

  void setAccessToken(String tempToken) {
    token = tempToken;
    print('token = $token');
    notifyListeners();
  }
}
