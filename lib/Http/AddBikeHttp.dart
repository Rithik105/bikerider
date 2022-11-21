import "dart:convert";

import "package:http/http.dart" as http;

import "../Utility/Secure_storeage.dart";

class AddBikeHttp {
  static Future addBikeDetails(AddBikeModel) async {
    String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.post(
      Uri.parse("https://riding-application.herokuapp.com/api/v1/bike/addBike"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'BEARER $token'
      },
      body: AddBikeModel,
    );
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  static Future addReview(String id, double rating, String dealerPhone) async {
    String? token = await UserSecureStorage.getToken();
    print(dealerPhone);
    print(token);
    final http.Response response = await http.post(
      Uri.parse(
          "https://riding-application.herokuapp.com/api/v1/service/reviewService"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'BEARER $token'
      },
      body: json.encode(
        {"_id": id, "ratings": rating, "dealerPhoneNumber": dealerPhone},
      ),
    );
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  static Future addBikeList() async {
    String? token = await UserSecureStorage.getToken();

    final http.Response response = await http.get(
      Uri.parse(
          "https://riding-application.herokuapp.com/api/v1/bike/getVehicleType"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'BEARER $token'
      },
    );
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }
}
