import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Utility/Secure_storeage.dart';

class GetBikeDetails {
  static Future getBikes() async {
    String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.get(
      Uri.parse(
          "https://ride-app-node.vercel.app/api/v1/bike/getBikeDetails"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'BEARER $token'
      },
    );
    // print(jsonDecode(response.body));
    // return response;
    return jsonDecode(response.body);
  }
}

class GetOwnerDetails {
  static Future getOwner() async {
    String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.get(
      Uri.parse(
          "https://ride-app-node.vercel.app/api/v1/owner/getOwnerDetails"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'BEARER $token'
      },
    );
    //print(response.body);
    // return response;
    return jsonDecode(response.body);
  }
}

class UpdateOwnerDetails {
  static Future updateOwner(encodeData) async {
    String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.post(
        Uri.parse(
            "https://ride-app-node.vercel.app/api/v1/owner/addOwnerDetails"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'BEARER $token'
        },
        body: encodeData);
    print(response.body);
    return jsonDecode(response.body);
  }
}
