import 'dart:async';
import 'dart:developer' as developer;

import 'package:daneshyar/core/constants/api_endpoints.dart';
import 'package:daneshyar/core/constants/strings.dart';
import 'package:daneshyar/core/network/token_storage.dart';
import 'package:daneshyar/features/authentication/auth/complete_profile/model/compelete_profile_response.dart';
import 'package:daneshyar/features/authentication/auth/login/model/send_code_response.dart';
import 'package:daneshyar/features/authentication/auth/otp/model/otp_verify_request.dart';
import 'package:daneshyar/features/authentication/auth/otp/model/otp_verify_response.dart';
import 'package:daneshyar/features/authentication/auth/refresh_token/model/refresh_token_response.dart';
import 'package:dio/dio.dart';

import '../complete_profile/model/complete_profile_request.dart';
import '../login/model/send_code_request.dart';

class AuthService {
  final Dio _authLessDio;
  final TokenStorage _storage;
  final Dio _dio;

  Completer<void>? _refreshCompleter;

  AuthService({
    required Dio authLessDio,
    required TokenStorage storage,
    required Dio dio,
  }) : _authLessDio = authLessDio,
       _dio = dio,
       _storage = storage;

  Future<SendCodeResponse> sendCode({required SendCodeRequest request}) async {
    final response = await _authLessDio.post(
      ApiEndpoints.sendOtp,
      data: request.toJson(),
      options: Options(
        contentType: Headers.jsonContentType,
        headers: {'Accept': 'application/json'},
      ),
    );

    final loginCodeResponse = SendCodeResponse.fromJson(response.data);
    if (loginCodeResponse.status != true) {
      throw Exception(AppStrings.sendInvalidPhoneNumber);
    } else {
      return loginCodeResponse;
    }
  }

  Future<OtpVerifyResponse> verifyOtpLogin({required OtpVerifyRequest request}) async {
    final response = await _authLessDio.post(
      ApiEndpoints.verifyOtp,
      data: request.toJson(),
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {'content-type': 'application/json'},
      ),
    );

    final verifyResponse = OtpVerifyResponse.fromJson(response.data);

    if (verifyResponse.status != true ||
        verifyResponse.data.accessToken.isEmpty) {
      throw Exception(verifyResponse.errorMessage ?? 'خطا در ورود');
    }
    await _storage.writeAccessToken(verifyResponse.data.accessToken);

    return verifyResponse;
  }

  Future<void> refreshTokenIfNeeded() async {
    if (_refreshCompleter != null) {
      return _refreshCompleter!.future;
    }
    _refreshCompleter = Completer<void>();
    try {
      final currentAccessToken = await _storage.readAccessToken();
      if (currentAccessToken == null) {
        throw Exception('No access token available for refresh.');
      }

      final response = await _authLessDio.post(
        ApiEndpoints.refreshToken,
        options: Options(
          headers: {'Authorization': 'Bearer $currentAccessToken'},
        ),
      );
      final refreshToken = RefreshTokenResponse.fromJson(response.data);
      final newAccessToken = refreshToken.accessToken;
      if (newAccessToken.isEmpty) {
        throw Exception('Refresh failed: New access token is empty');
      }

      await _storage.writeAccessToken(newAccessToken);
      _refreshCompleter!.complete();
    } catch (e, st) {
      await logout();
      _refreshCompleter!.completeError(e, st);
      rethrow;
    } finally {
      _refreshCompleter = null;
    }
  }

  Future<CompleteProfileResponse> completeProfile({
    required CompleteProfileRequest request,
  }) async {
    developer.log("in auth service --> completeProfile ");
    final fromData = FormData.fromMap({
      'fullname': request.fullName,
      if (request.avatar != null && request.avatar!.isNotEmpty)
        'avatar': await MultipartFile.fromFile(request.avatar!),
    });
    developer.log("form data : $fromData");

    final response = await _dio.post(
      ApiEndpoints.completeProfile,
      data: fromData,
      options: Options(contentType: null),
    );
    developer.log("response :  $response");

    return CompleteProfileResponse.fromJson(response.data);
  }

  Future<void> logout() async {
    await _storage.clearTokens();

    /// Todo Call api to logout
  }
}
