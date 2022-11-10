import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _secureStorage = FlutterSecureStorage();
  static const _key = 'token';
  static Future setToken(String token) async {
    await _secureStorage.write(key: _key, value: token);
  }

  static Future<String?> getToken() async {
    return await _secureStorage.read(key: _key);
  }
}
