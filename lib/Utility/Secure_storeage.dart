import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _secureStorage = FlutterSecureStorage();

  static Future setToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }

  static Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }

  static Future setDetails({required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String?> getDetails({required String key}) async {
    return await _secureStorage.read(key: key);
  }
}
