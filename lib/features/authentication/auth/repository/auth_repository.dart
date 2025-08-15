import 'package:daneshyar/features/authentication/auth/otp/model/otp_request.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/error_mapper.dart';

class AuthRepository {
  final ApiClient _api = ApiClient();

  Future<SendCodeResponse> sendCode({
    required String phoneNumber,
  }) async {
    try {
     final loginCode =  await _api.authService.sendCode(phoneNumber: phoneNumber);
     return SendCodeResponse(loginCode: loginCode, status: false); // change status later
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
