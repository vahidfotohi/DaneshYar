import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenStorage{
  Future<String?> readAccessToken();
  Future<String?> readRefreshToken();
  Future<void> writeAccessToken(String token);
  Future<void> writeRefreshToken(String token);
  Future<void> clearTokens();
}

class SecureTokenStorage implements TokenStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // SecureTokenStorage(this._secureStorage);

  @override
  Future<String?> readAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  @override
  Future<String?> readRefreshToken() async {
    return await _secureStorage.read(key: 'refresh_token');
  }

  @override
  Future<void> writeAccessToken(String token) async {
    await _secureStorage.write(key: 'access_token', value: token);
  }

  @override
  Future<void> writeRefreshToken(String token) async {
    await _secureStorage.write(key: 'refresh_token', value: token);
  }

  @override
  Future<void> clearTokens() async {
    await _secureStorage.delete(key: 'access_token');
    await _secureStorage.delete(key: 'refresh_token');
  }
}