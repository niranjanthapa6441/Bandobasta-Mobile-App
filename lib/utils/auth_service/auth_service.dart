// auth_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthService {
  final _storage = FlutterSecureStorage();

  Future<void> storeToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  Future<void> clearToken() async {
    await _storage.delete(key: 'jwt_token');
  }

  Future<void> storeUserId(String id) async {
    await _storage.write(key: 'user_id', value: id);
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: 'user_id');
  }

  Future<void> clearUserId() async {
    await _storage.delete(key: 'user_id');
  }

  Future<bool> isTokenExpired() async {
    String? token = await getToken();
    if (token != null) {
      bool isExpired = Jwt.isExpired(token);
      return isExpired;
    }
    return true;
  }
}
