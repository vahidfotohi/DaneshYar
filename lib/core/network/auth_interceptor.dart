import 'package:dio/dio.dart';
import 'token_storage.dart';
import '../auth/auth_service.dart';

class AuthInterceptor extends QueuedInterceptorsWrapper {
  final TokenStorage storage;
  final AuthService authService;

  AuthInterceptor({
    required this.storage,
    required this.authService,
  });

  bool _isAuthFree(String path) {
    // مسیرهای که نباید Authorization داشته باشند
    return path.contains('/auth/login') ||
        path.contains('/auth/register') ||
        path.contains('/client/refresh');
  }

  bool _shouldTryRefresh(DioException error) {
    final status = error.response?.statusCode ?? 0;
    final path = error.requestOptions.path;
    return status == 401 && !_isAuthFree(path);
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
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
      DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldTryRefresh(err)) {
      try {
        // تلاش برای رفرش
        await authService.refreshTokenIfNeeded();

        // اجرای مجدد همان درخواست با توکن جدید
        final newAccess = await storage.readAccessToken();
        final ro = err.requestOptions;

        // بروزرسانی هدر
        final newHeaders = Map<String, dynamic>.from(ro.headers);
        if (newAccess != null) {
          newHeaders['Authorization'] = 'Bearer $newAccess';
        }

        final retryResponse = await err.requestOptions
            .copyWith(headers: newHeaders)
            ._retry();

        return handler.resolve(retryResponse);
      } catch (_) {
        // شکست رفرش → پاک‌سازی و عبور خطا
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
    final dio = this.extra['dio_instance'] as Dio?;
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
