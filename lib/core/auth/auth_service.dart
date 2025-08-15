import 'dart:async';

import 'package:daneshyar/core/network/token_storage.dart';
import 'package:dio/dio.dart';

class AuthService {
  final Dio _authLessDio;
  final TokenStorage _storage;

  Completer<void>? _refreshCompleter;

  AuthService({required Dio authLessDio, required TokenStorage storage})
    : _authLessDio = authLessDio,
      _storage = storage;

  Future<String> sendCode({
    required String phoneNumber,
}) async {
    final response = await _authLessDio.post('/client/sendCode',data: {'phone_number' : phoneNumber},
    options: Options(contentType: Headers.jsonContentType,headers: {'Accept' : 'application/json'}));
    if (response.statusCode == 200 && response.data['status'] == true) {
      // گرفتن login_code
      final loginCode = response.data['data']['login_code'];
      return loginCode;
    } else {
      throw Exception(response.data['error'] ?? 'خطای ناشناخته');
    }

  }

  Future<void> login({
    required String code,
    required String loginCode,
  }) async {
    final response = await _authLessDio.post('/client/login',
      data: {'code': code, 'login_code': loginCode},
      options: Options(contentType: Headers.jsonContentType, headers: {'Accept': 'application/json'}),
    );
    final data = response.data as Map<String, dynamic>;
    final access = data['access_token'] as String?;
    final refresh = data['refresh_token'] as String?;
    if (access == null || refresh == null) {
      throw Exception('Login failed: Access or refresh token is null');
    }
    await _storage.writeAccessToken(access);
    await _storage.writeRefreshToken(refresh);
  }

  Future<void> refreshTokenIfNeeded() async {
    if (_refreshCompleter != null) {
      return _refreshCompleter!.future;
    }
    _refreshCompleter = Completer<void>();
    try {
      final refreshToken = await _storage.readRefreshToken();
      if (refreshToken == null) {
        throw Exception('No refresh token available');
      }

      final response = await _authLessDio.post(
        '/client/refresh',
        data: {'refresh_token': refreshToken},
        options: Options(contentType: Headers.jsonContentType, headers: {'Accept': 'application/json'}),
      );

      final data = response.data as Map<String, dynamic>;
      final newAccess = data['access_token'] as String?;
      final newRefresh = data['refresh_token'] as String?;

      if (newAccess == null || newRefresh == null) {
        throw Exception('Refresh failed: Access or refresh token is null');
      }

      await _storage.writeAccessToken(newAccess);
      if (newRefresh.isNotEmpty) {
        await _storage.writeRefreshToken(newRefresh);
      }
      _refreshCompleter!.complete();
    } catch (e, st) {
      _refreshCompleter!.completeError(e, st);
      rethrow;
    } finally {
      _refreshCompleter = null;
    }
  }

  Future<void> logout() async {
    await _storage.clearTokens();
    // Notify the app about logout, e.g., using a stream or state management solution.
  }
}
