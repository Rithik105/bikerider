import 'dart:convert';
import 'dart:io';

import 'package:bikerider/Models/timeLineModel.dart';
import "package:http/http.dart" as http;
import 'package:path/path.dart';

import '../Models/UserModel.dart';
import '../Utility/Secure_storeage.dart';

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

    print(response.body);
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
    print("hi");
    print(jsonDecode(response.body)["token"]);

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

  static Future getNumber(String token) async {
    final http.Response secret = await http.get(
        Uri.parse(
            "https://riding-application.herokuapp.com/api/v1/getMyNumber"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'BEARER $token'
        });
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

  static Future createTrip(String createTripModal) async {
    UserSecureStorage.getToken().then((value) async {
      final http.Response response = await http.post(
          Uri.parse(
              "https://riding-application.herokuapp.com/api/v1/trip/createTrip"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'BEARER $value'
          },
          body: createTripModal);
      print("tried to upload");
      print(response.body);
      return jsonDecode(response.body);
    });
  }

  static Future<void> deleteTrip(String id) async {
    UserSecureStorage.getToken().then((value) async {
      final http.Response response = await http.post(
          Uri.parse(
              'https://riding-application.herokuapp.com/api/v1/trip/deleteTrip'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'BEARER $value'
          },
          body: jsonEncode({'_id': id}));
      print(value);
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    });
  }

  static Future<List> getTrips(String token) async {
    final http.Response response = await http.get(
        Uri.parse(
            "https://riding-application.herokuapp.com/api/v1/trip/getTrip"),
        headers: {'Authorization': 'BEARER $token'});

    print(" hello world ${jsonDecode(response.body)}");
    return jsonDecode(response.body);
  }

  static Future sendChat(String groupId, String token, String message) async {
    final http.Response response = await http.post(
        Uri.parse(
            'https://riding-application.herokuapp.com/api/v1/chat/createChat'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'BEARER $token'
        },
        body: jsonEncode({'chat': message, 'groupId': groupId}));
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  static Future<List> getChats(String groupId, String token) async {
    final http.Response response = await http.post(
        Uri.parse(
            'https://riding-application.herokuapp.com/api/v1/chat/getChatDetails'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'BEARER $token'
        },
        body: jsonEncode({'groupId': groupId}));
    return jsonDecode(response.body);
  }
}

class UserImageHttp {
  static Future submitSubscription(
      {required File file, required String token}) async {
    var request = await registerSubscription(token);
    request.files.add(
      http.MultipartFile(
          'image', file.readAsBytes().asStream(), file.lengthSync(),
          filename: basename(file.path)),
    );
    print(request.files.first.filename.toString());
    var res = request.send().then((value) {
      print("this is executed");
      value.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
      print("hi");
    });
  }

  static Future<http.MultipartRequest> registerSubscription(
      String token) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          "https://riding-application.herokuapp.com/api/v1/profileImageUpload"),
    );
    Map<String, String> headers = {
      "Content-type":
          "multipart/form-data; boundary=<calculated when request is sent>",
      "Authorization": "BEARER $token",
    };
    request.headers.addAll(headers);
    return request;
  }
}

Future<TimeLineModel> getTimeline() async {
  final token = await UserSecureStorage.getToken();
  // print('Token  ' + token.toString());
  final response = await http.get(
    Uri.parse("https://riding-application.herokuapp.com/api/v1/trip/timeline"),
    headers: {'Authorization': 'BEARER $token'},
  );

  print("${jsonDecode(response.body)}");
  print(
    'T  ' +
        TimeLineModel.fromJson(jsonDecode(response.body))
            .tripList
            .length
            .toString(),
  );
  return TimeLineModel.fromJson(jsonDecode(response.body));
}
