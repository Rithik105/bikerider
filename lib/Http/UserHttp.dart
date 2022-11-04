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
    print(response.body);
  }

  static Future loginUserEmail(User user) async {
    final http.Response response = await http.post(
        Uri.parse("https://riding-application.herokuapp.com/api/v1/loginEmail"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"email": user.email, "password": user.password}));
    print(response.body);
  }

  static Future loginUserNumber(User user) async {
    final http.Response response = await http.post(
        Uri.parse("https://riding-application.herokuapp.com/api/v1/loginPhone"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"mobile": user.email, "password": user.password}));
    print(response.body);
  }
}
