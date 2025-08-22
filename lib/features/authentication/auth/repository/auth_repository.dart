import 'package:daneshyar/features/authentication/auth/complete_profile/model/compelete_profile_response.dart';
import 'package:daneshyar/features/authentication/auth/login/model/send_code_request.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/error_mapper.dart';
import '../complete_profile/model/complete_profile_request.dart';
import '../otp/model/otp_verify_request.dart';
import 'dart:developer' as developer;
class AuthRepository {
  final ApiClient _api = ApiClient();

  Future<String> sendCode({
    required String phoneNumber,
  }) async {
    try {
      final request = SendCodeRequest(phoneNumber: phoneNumber);
      final loginCode = await _api.authService.sendCode(request: request);
      developer.log(loginCode);
      return loginCode;
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyOtpAndLogin({
    required String code,
    required String loginCode,

}) async {
    try {
      final request = OtpVerifyRequest(code: code, loginCode: loginCode);
      await _api.authService.verifyOtpLogin(request: request);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<CompleteProfileResponse> completeProfile({
    required CompleteProfileRequest request,
}) async {
    try {
      final response = await _api.authService.completeProfile(request: request);
      return response;
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _api.authService.logout();
  }

  Future<bool> isAuthenticated() async {
    final token = await _api.tokenStorage.readAccessToken();
    return token != null && token.isNotEmpty;
  }
}
