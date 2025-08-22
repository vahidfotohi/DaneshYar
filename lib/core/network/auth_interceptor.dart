import 'package:dio/dio.dart';
import '../../features/authentication/auth/service/auth_service.dart';
import 'token_storage.dart';

class AuthInterceptor extends QueuedInterceptorsWrapper {
  final TokenStorage storage;
  final AuthService authService;

  AuthInterceptor({required this.storage, required this.authService});

  bool _shouldTryRefresh(DioException error) {
    final status = error.response?.statusCode ?? 0;
    final path = error.requestOptions.path;
    return status == 401 && !_isAuthFree(path);
  }

  bool _isAuthFree(String path) {
    return path.contains('/client/login') || path.contains('/client/sendCode');
    // path.contains('/client/refresh');
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!_isAuthFree(options.path)) {
      final access = await storage.readAccessToken();
      if (access != null) {
        options.headers['Authorization'] = 'Bearer $access';
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_shouldTryRefresh(err)) {
      try {
        await authService.refreshTokenIfNeeded();

        final newAccess = await storage.readAccessToken();
        final requestOption = err.requestOptions;


        final newHeaders = Map<String, dynamic>.from(requestOption.headers);
        if (newAccess != null) {
          newHeaders['Authorization'] = 'Bearer $newAccess';
        }

        final retryResponse = await err.requestOptions
            .copyWith(headers: newHeaders)
            ._retry();

        return handler.resolve(retryResponse);
      } catch (_) {
        await authService.logout();
        return handler.next(err);
      }
    }

    handler.next(err);
  }

}

/// اکستنشن کمکی برای Retry کامل همان درخواست
extension _RetryRequest on RequestOptions {
  Future<Response<dynamic>> _retry() {
    final dio = extra['dio_instance'] as Dio?;
    if (dio == null) {
      // اگر dio را تزریق نکرده باشیم، از owner همان err استفاده می‌کنیم
      // (در api_client این extra را ست می‌کنیم)
      throw StateError('Missing dio_instance in RequestOptions.extra');
    }

    final options = Options(
      method: method,
      headers: headers,
      responseType: responseType,
      contentType: contentType,
      followRedirects: followRedirects,
      receiveDataWhenStatusError: receiveDataWhenStatusError,
      extra: extra,
      validateStatus: validateStatus,
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
    );

    return dio.request<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
  }
}
