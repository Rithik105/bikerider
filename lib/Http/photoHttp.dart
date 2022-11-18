import 'dart:convert';
import 'package:http/http.dart' as http;

class PhotosHttp {
  static Future getGallery(String tripId, String token) async {
    int _page = 1;
    int _limit = 8;
    //String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.post(
      body: jsonEncode({'tripId': tripId}),
      Uri.parse(
          "https://riding-application.herokuapp.com/api/v1/chat/getImagePreview?page=$_page&limit=$_limit"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'BEARER $token',
      },
    );
    print(response.body);
    // return response;
    return jsonDecode(response.body);
  }

  static Future getPhotos(String token) async {
    //String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.post(
      body: jsonEncode({'tripId': '6373141675818e2c99e5776'}),
      Uri.parse(
          "https://riding-application.herokuapp.com/api/v1/chat/getImagePreview"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'BEARER $token',
      },
    );
    print(response.body);
    // return response;
    return jsonDecode(response.body);
  }

  static Future getPhotoDetails(String id, String token) async {
    //String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.post(
      body: jsonEncode({'_id': id}),
      Uri.parse(
          "https://riding-application.herokuapp.com/api/v1/chat/getTripPhotos"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'BEARER $token',
      },
    );
    //  print(response.body);
    // return response;
    return jsonDecode(response.body);
  }

  static Future addLike(String id, String token) async {
    //String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.post(
      body: jsonEncode({'id': id}),
      Uri.parse(
          "https://riding-application.herokuapp.com/api/v1/chat/addLikes"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'BEARER $token',
      },
    );
    //  print(response.body);
    // return response;
    return jsonDecode(response.body);
  }

  static Future addComment(String id, String comment, String token) async {
    //String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.post(
      body: jsonEncode({'id': id, "comments": comment}),
      Uri.parse(
          "https://riding-application.herokuapp.com/api/v1/chat/addComments"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'BEARER $token',
      },
    );
    //  print(response.body);
    // return response;
    return jsonDecode(response.body);
  }
}