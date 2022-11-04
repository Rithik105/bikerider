import 'dart:convert';

import "package:http/http.dart" as http;

import '../Models/UserModel.dart';

class UserHttp {
  static Future createUser(User user) async {
    final http.Response response = await http.post(
        Uri.parse("https://riding-application.herokuapp.com/api/v1/register"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "userName": user.name,
          "email": user.email,
          "mobile": user.mobile,
          "password": user.password
        }));
  }

  static Future loginUser(User user) async {
    final http.Response response = await http.post(
        Uri.parse("https://riding-application.herokuapp.com/api/v1/login"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"": user.email, "password": user.password}));
  }
}
