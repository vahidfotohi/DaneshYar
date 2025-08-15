import 'package:dio/dio.dart';
import '../network/api_client.dart';
import '../network/error_mapper.dart';

class AuthRepository {
  final ApiClient _api = ApiClient();

  Future<void> sendCode({
    required String phoneNumber,
  }) async {
    try {
      await _api.authService.sendCode(phoneNumber: phoneNumber);
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
