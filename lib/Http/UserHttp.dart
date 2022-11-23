import 'dart:convert';
import 'dart:io';

import 'package:bikerider/Models/timeLineModel.dart';
import 'package:bikerider/custom/widgets/ShowToast.dart';
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

    return jsonDecode(response.body);
  }

  static Future loginUserNumber(User user) async {
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
    if (jsonDecode(response.body)["messages"][0]["status"] == "29") {
      showToast(msg: "Please whitelist the number");
    } else
      showToast(msg: "OTP sent");
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

  static Future getToken(String token) async {
    final http.Response secret = await http.post(
      Uri.parse(
          "https://riding-application.herokuapp.com/api/v1/getAccessToken"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'BEARER $token'
      },
    );
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

    return jsonDecode(response.body);
  }

  static Future<List> searchTrips(String trip, String token) async {
    String value = "text";
    print(value.runtimeType);
    final http.Response response = await http.post(
        Uri.parse(
            "https://riding-application.herokuapp.com/api/v1/trip/searchTrip"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'BEARER $token'
        },
        body: jsonEncode({value: trip}));
    print(jsonDecode(response.body));

    return jsonDecode(response.body);
  }

  static Future<List> searchTripsDetails(String trip, String token) async {
    String value = "text";
    print(value.runtimeType);
    final http.Response response = await http.post(
        Uri.parse(
            "https://riding-application.herokuapp.com/api/v1/trip/searchAllTrips"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'BEARER $token'
        },
        body: jsonEncode({value: trip}));
    print(jsonDecode(response.body));

    return jsonDecode(response.body);
  }

  static Future followUser(String number, String token) async {
    final http.Response response = await http.post(
        Uri.parse("https://riding-application.herokuapp.com/api/v1/follow"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'BEARER $token'
        },
        body: jsonEncode({"wantToFollow": number}));
    print(response.body);
  }

  static Future<List> getTripDetails(String token) async {
    final http.Response response = await http.get(
        Uri.parse(
            "https://riding-application.herokuapp.com/api/v1/trip/getTripDetails"),
        headers: {'Authorization': 'BEARER $token'});

    print(" hello world ${jsonDecode(response.body)}");
    return jsonDecode(response.body);
  }

  static Future sendChat(String groupId, String token, String message,
      {bool isImage = false}) async {
    final http.Response response = await http.post(
        Uri.parse(
            'https://riding-application.herokuapp.com/api/v1/chat/createChat'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'BEARER $token'
        },
        body: jsonEncode(
            {'chat': message, 'groupId': groupId, 'isImage': isImage}));
    return jsonDecode(response.body);
  }

  static Future getChats(String groupId, String token) async {
    final http.Response response = await http.post(
        Uri.parse(
            'https://riding-application.herokuapp.com/api/v1/chat/getChatDetails'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'BEARER $token'
        },
        body: jsonEncode({'groupId': groupId}));
    // print(" chat ${jsonDecode(response.body)}");
    return jsonDecode(response.body);
  }

  static Future<Map> getAccessories(String item, String token) async {
    final http.Response response = await http.post(
        Uri.parse(
            "https://riding-application.herokuapp.com/api/v1/product/searchProducts"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'BEARER $token'
        },
        body: jsonEncode({'text': item}));
    return jsonDecode(response.body);
  }

  static Future<Map> userLogOut(String token) async {
    final http.Response response = await http.post(
      Uri.parse("https://riding-application.herokuapp.com/api/v1/logout"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'BEARER $token'
      },
    );
    return jsonDecode(response.body);
  }

  static Future<List> getToolKit(String item) async {
    final http.Response response = await http.post(
        Uri.parse(
            "https://riding-application.herokuapp.com/api/v1/tool/viewToolKit"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'text': item}));
    return jsonDecode(response.body);
  }

  static Future accLike(String id, bool like, String token) async {
    final http.Response response = await http.post(
        Uri.parse(
            "https://riding-application.herokuapp.com/api/v1/product/addLike"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'BEARER $token'
        },
        body: jsonEncode({"_id": id, "likes": like}));
    print(id);
    print(jsonDecode(response.body));
  }

  static Future<Map> getProfile(String token, String number) async {
    final http.Response response = await http.post(
        Uri.parse("https://riding-application.herokuapp.com/api/v1/getProfile"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'BEARER $token'
        },
        body: jsonEncode({"mobile": number}));
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  static Future<TimeLineModel> getTimeline() async {
    final token = await UserSecureStorage.getToken();
    // print('Token  ' + token.toString());
    final response = await http.get(
      Uri.parse(
          "https://riding-application.herokuapp.com/api/v1/trip/timeline"),
      headers: {'Authorization': 'BEARER $token'},
    );

    print("Response: ${jsonDecode(response.body)}");
    print(
      'T  ${TimeLineModel.fromJson(jsonDecode(response.body)).tripList.length}',
    );
    return TimeLineModel.fromJson(jsonDecode(response.body));
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
    request.send().then((value) {
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

class UserChatImageHttp {
  static Future clearChats(
      {required String groupId, required String token}) async {
    print('token' + token);
    print('groupId' + groupId);
    final http.Response response = await http.post(
      Uri.parse(
          "https://riding-application.herokuapp.com/api/v1/chat/clearChat"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'BEARER $token'
      },
      body: jsonEncode({"groupId": groupId}),
    );
    print(token);
    print(groupId);
    print(response.toString());
    print('---------------------------------');
    print('000000000' + jsonDecode(response.body).toString());
  }

  static Future submitSubscription(
      {required File file,
      required String token,
      required String groupId}) async {
    var request = await registerSubscription(token);
    request.files.add(
      http.MultipartFile(
          'image', file.readAsBytes().asStream(), file.lengthSync(),
          filename: basename(file.path)),
    );
    request.fields.addAll({"id": groupId});
    print(request.files.first.filename.toString());
    request.send().then((value) {
      print("this is executed");
      value.stream.transform(utf8.decoder).listen((value) {
        print('value' + value.toString());
        if (jsonDecode(value)['message'] == 'Image upload successfull !') {
          UserHttp.sendChat(groupId, token, jsonDecode(value)['url'],
                  isImage: true)
              .then((value1) {
            print(value1);
          });
        }
      });
      print("hi");
    });
  }

  static Future<http.MultipartRequest> registerSubscription(
      String token) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          "https://riding-application.herokuapp.com/api/v1/chat/uploadChatImage"),
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

class UserProfileEditHttp {
  static Future editImage({required File file, required String token}) async {
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
          "https://riding-application.herokuapp.com/api/v1/editProfileImage"),
    );
    Map<String, String> headers = {
      "Content-type":
          "multipart/form-data; boundary=<calculated when request is sent>",
      "Authorization": "BEARER $token",
    };
    request.headers.addAll(headers);
    return request;
  }

  static Future editInfo(
      {required String name,
      required String aboutUser,
      required String token}) async {
    final http.Response response = await http.post(
        Uri.parse(
            "https://riding-application.herokuapp.com/api/v1/editProfile"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'BEARER $token'
        },
        body: jsonEncode({"aboutUser": aboutUser, "userName": name}));

    print(jsonDecode(response.body));
  }
}
