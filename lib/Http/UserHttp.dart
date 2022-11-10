import 'dart:convert';
import 'dart:io';

import "package:http/http.dart" as http;

import 'package:path/path.dart';
import '../Models/UserModel.dart';
import 'package:http_parser/http_parser.dart';

class UserHttp {
  static Future registerUser(User user) async {
    final http.Response response = await http.post(
        Uri.parse("https://riding-application.herokuapp.com/api/v1/register"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "userName": user.name,
          "email": user.email,
          "mobile": user.mobile,
          "password": user.password,
          "haveBike": "true"
        }));
    return jsonDecode(response.body);
  }

  static Future loginUserEmail(User user) async {
    final http.Response response = await http.post(
        Uri.parse("https://riding-application.herokuapp.com/api/v1/loginEmail"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"email": user.email, "password": user.password}));
    return jsonDecode(response.body);
  }

  static Future loginUserNumber(User user) async {
    print(user.mobile);
    final http.Response response = await http.post(
        Uri.parse("https://riding-application.herokuapp.com/api/v1/loginPhone"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"mobile": user.mobile, "password": user.password}));

    return jsonDecode(response.body);
  }

  static Future changePassword(String mobile, String password) async {
    final http.Response response = await http.post(
        Uri.parse(
            "https://riding-application.herokuapp.com/api/v1/forgotPassword"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"mobile": mobile, "password": password}));
    return jsonDecode(response.body);
  }

  static Future sendOtp(String number) async {
    final http.Response response = await http.post(
        Uri.parse("https://riding-application.herokuapp.com/api/v1/sendOtp"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"destination": "+91$number"}));
    print('sendotp');
    return jsonDecode(response.body);
  }

  static Future verifyOtp(String pin) async {
    final http.Response secret = await http.post(
        Uri.parse("https://riding-application.herokuapp.com/api/v1/verifyOtp"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"otp": pin}));
    return jsonDecode(secret.body);
  }

  static Future getToken(String pin) async {
    final http.Response secret = await http.post(
        Uri.parse(
            "https://riding-application.herokuapp.com/api/v1/getAccessToken"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"otp": pin}));
    return jsonDecode(secret.body);
  }

  static Future<List> getTrips(String token) async {
    final http.Response response = await http.get(
        Uri.parse(
            "https://riding-application.herokuapp.com/api/v1/trip/getTrip"),
        headers: {'Authorization': 'BEARER $token'});
    return jsonDecode(response.body);
  }
}

class UserImageHttp {
  static Future submitSubscription({required File file}) async {
    var request = await registerSubscription();
    request.files.add(
      http.MultipartFile(
          'image', file.readAsBytes().asStream(), file.lengthSync(),
          filename: basename(file.path)),
    );
    print(request.files.first.filename.toString());
    var res = await request.send().then((value) {
      value.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    });
  }

  static Future<http.MultipartRequest> registerSubscription() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          "https://riding-application.herokuapp.com/api/v1/profileImageUpload"),
    );
    Map<String, String> headers = {
      "Content-type":
          "multipart/form-data; boundary=<calculated when request is sent>"
    };
    request.headers.addAll(headers);
    return request;
  }
}
