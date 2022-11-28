import 'dart:convert';

import "package:http/http.dart" as http;

import '../Models/book_service_model.dart';
import '../Models/prefill_model.dart';
import '../Utility/Secure_storeage.dart';

class BookServiceHttp {
  static Future<http.Response> getWorkstations(String search) async {
    String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.post(
        Uri.parse(
            "https://ride-app-node.vercel.app/api/v1/dealer/searchDealers"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'BEARER $token'
        },
        body: jsonEncode({"text": search}));

    return response;
  }

  static Future<PrefillModel> prefillDetails() async {
    String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.get(
        Uri.parse(
            "https://ride-app-node.vercel.app/api/v1/service/prefilledService"),
        headers: {
          'Authorization': 'BEARER $token',
          'Content-Type': 'application/json'
        });
    print(jsonDecode(response.body));
    return PrefillModel.fromJson(jsonDecode(response.body));

    //return PrefillModel(mobile: '', prefill: []);
  }

  // static Future<PrefillModel> prefillDetails() async {
  //  await UserSecureStorage.getToken().then((value) async {
  //     final http.Response response = await http.get(
  //         Uri.parse(
  //             "https://riding-application.herokuapp.com/api/v1/service/prefilledService"),
  //         headers: {
  //           'Authorization': 'BEARER $value',
  //           'Content-Type': 'application/json',
  //         });
  //     return PrefillModel.fromJson(jsonDecode(response.body));
  //   });
  //     return PrefillModel(mobile: '', prefill: []);
  //
  // }

  // static Future<PrefillModel> prefillDetails() async {
  //   Map tmp = {
  //     "mobile": "9480439398",
  //     "prefilled": [
  //       {
  //         "_id": "636e3481fe21f71e4a0d2e3a",
  //         "vehicleType": "Continental gt 650",
  //         "vehicleNumber": "KA 47 MK 7025"
  //       },
  //       {
  //         "_id": "636e34a5fe21f71e4a0d2e3d",
  //         "vehicleType": "Classic 350",
  //         "vehicleNumber": "KA 19 MK 9821"
  //       }
  //     ]
  //   };
  //   // return jsonDecode(response.body);
  //   return PrefillModel.fromJson(tmp);
  //   // return tmp;
  // }

  // static Future uploadBookingDetails(String dealerPhone) async {
  //   print(BookServiceModel.vehicleNumber);
  //   print(BookServiceModel.serviceType);
  //   String? token = await UserSecureStorage.getToken();
  //
  //   final http.Response response = await http.post(
  //       Uri.parse(
  //           "https://riding-application.herokuapp.com/api/v1/service/bookService"),
  //       headers: {
  //         'Authorization': 'BEARER $token',
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode(BookServiceModel.toJson()));
  //   print(jsonDecode(response.body));
  //   return jsonDecode(response.body);
  // }

  static Future<Map> uploadBookingDetails(String dealerPhone) async {
    String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.post(
        Uri.parse(
            "https://ride-app-node.vercel.app/api/v1/service/bookService"),
        headers: {
          'Authorization': 'BEARER $token',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          "vehicleNumber": BookServiceModel.vehicleNumber,
          "serviceType": BookServiceModel.serviceType,
          "slotDate": BookServiceModel.slotDate.toString(),
          "time": BookServiceModel.slotTime,
          "dealer": BookServiceModel.dealerName,
          "city": BookServiceModel.dealerCity,
          "comments": BookServiceModel.comments,
          "dealerPhoneNumber": dealerPhone
        }));
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  static Future getBookingDetails(
      String vehicleType, String serviceType) async {
    String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.post(
        Uri.parse(
            "https://ride-app-node.vercel.app/api/v1/service/getServiceDetails"),
        headers: {
          'Authorization': 'BEARER $token',
          'Content-Type': 'application/json'
        },
        body: json
            .encode({"vehicleType": vehicleType, "serviceType": serviceType}));

    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  static Future getInvoiceDetails(String id) async {
    String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.post(
        Uri.parse("https://ride-app-node.vercel.app/api/v1/service/getInvoice"),
        headers: {
          'Authorization': 'BEARER $token',
          'Content-Type': 'application/json'
        },
        body: json.encode({"serviceId": id}));
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  static Future getSortedServiceList() async {
    String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.get(
      Uri.parse(
          "https://ride-app-node.vercel.app/api/v1/service/getAllService"),
      headers: {
        'Authorization': 'BEARER $token',
        'Content-Type': 'application/json'
      },
    );
    // print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  static Future updatePhoneNumber(String phone) async {
    String? token = await UserSecureStorage.getToken();
    final http.Response response = await http.post(
        Uri.parse(
            "https://ride-app-node.vercel.app/api/v1/service/updateMobileNumber"),
        headers: {
          'Authorization': 'BEARER $token',
          'Content-Type': 'application/json'
        },
        body: json.encode({"mobile": phone, "token": token}));

    return jsonDecode(response.body);
  }
}
