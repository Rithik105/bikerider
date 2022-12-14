import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Screens/gallery/gallery_model.dart';

class PhotosHttp {
  static Future getGallery(
      String tripId, String token, int page, int limit) async {
    //String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.post(
      body: jsonEncode({'groupId': tripId}),
      Uri.parse(
          "https://ride-app-node.vercel.app/api/v1/chat/getImagePreview?page=$page&limit=$limit"),
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
      Uri.parse("https://ride-app-node.vercel.app/api/v1/chat/getImagePreview"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'BEARER $token',
      },
    );
    print(response.body);
    // return response;
    return jsonDecode(response.body);
  }

  static Future<ImageDetails> getPhotoDetails(String id, String token) async {
    //String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.post(
      body: jsonEncode({'_id': id}),
      Uri.parse(
          "https://ride-app-node.vercel.app/api/v1/chat/getParticularPhoto"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'BEARER $token',
      },
    );
    //print('getPhotoAPIr${jsonDecode(response.body)['distinctComment']}');
    // return response;
    return ImageDetails.fromJson(jsonDecode(response.body));
  }

  static Future addLike(String id, String token) async {
    //String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.post(
      body: jsonEncode({'id': id}),
      Uri.parse("https://ride-app-node.vercel.app/api/v1/chat/addLikes"),
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
      Uri.parse("https://ride-app-node.vercel.app/api/v1/chat/addComments"),
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
