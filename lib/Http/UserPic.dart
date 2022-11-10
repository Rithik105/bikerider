import 'dart:convert';
import 'dart:io';
import 'dart:async';

import "package:http/http.dart" as http;
import 'package:path/path.dart';

class UserPhotoHttp {
  static Future imageUpload(File? image) async {
    var stream = http.ByteStream(image!.openRead());

    var length = await image.length();

    var uri = Uri.parse(
        "https://riding-application.herokuapp.com/api/v1/profileImageUpload");

    var request = http.MultipartRequest("POST", uri);
    print(basename(image.path));

    var multipartFileSign = http.MultipartFile('image', stream, length,
        filename: basename(image.path));
    var response = await request.send();

    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
}
