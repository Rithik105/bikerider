import 'dart:convert';
import 'dart:io';

import "package:http/http.dart" as http;

import '../Models/UserModel.dart';

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
          "password": user.password
        }));
    return jsonDecode(response.body);
  }

  static Future<Map> loginUserEmail(User user) async {
    final http.Response response = await http.post(
        Uri.parse("https://riding-application.herokuapp.com/api/v1/loginEmail"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"email": user.email, "password": user.password}));
    return jsonDecode(response.body);
  }

  static Future loginUserNumber(User user) async {
    final http.Response response = await http.post(
        Uri.parse("https://riding-application.herokuapp.com/api/v1/loginPhone"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"mobile": user.email, "password": user.password}));
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

  static Future getsecret() async {
    final http.Response response = await http.get(
        Uri.parse("https://riding-application.herokuapp.com/api/v1/getSecret"));
    final secretKey = jsonDecode(response.body)["secret"];
    print(secretKey);
    return secretKey;
  }

  static Future sendOtp(String key, String number) async {
    final http.Response response = await http.post(
        Uri.parse("https://riding-application.herokuapp.com/api/v1/sendOtp"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"secret": key, "destination": "+91$number"}));
    print('sendotp');
    return jsonDecode(response.body);
  }

  static Future verifyOtp(String pin, String mobile) async {
    final http.Response secret = await http.post(
        Uri.parse("https://riding-application.herokuapp.com/api/v1/verifyOtp"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"mobile": mobile, "pin": pin}));
    return jsonDecode(secret.body);
  }

  static Future imageUpload({File? image}) async {
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var request = new http.MultipartRequest(
        "POST",
        Uri.parse(
            "https://riding-application.herokuapp.com/api/v1/profileImageUpload"));
    request.fields["title"] = "Static title";
    var multiport = new http.MultipartFile("Image", stream, length);
    request.files.add(multiport);
    var response = await request.send();
    if (response.statusCode == 200) {
      print("image uploaded");
    } else {
      print("failed");
    }
  }
}
