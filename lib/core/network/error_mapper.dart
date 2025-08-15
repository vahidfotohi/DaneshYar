import 'package:dio/dio.dart';

class PrettyError implements Exception {
  final String message;
  final int? statusCode;
  PrettyError(this.message, {this.statusCode});
  @override
  String toString() => 'PrettyError($statusCode): $message';
}

PrettyError mapDioError(Object error) {
  if (error is DioException) {
    final status = error.response?.statusCode;
    switch (status) {
      case 400:
        return PrettyError('درخواست نامعتبر است.', statusCode: status);
      case 401:
        return PrettyError('نیاز به ورود مجدد دارید.', statusCode: status);
      case 403:
        return PrettyError('دسترسی غیرمجاز.', statusCode: status);
      case 404:
        return PrettyError('موردی یافت نشد.', statusCode: status);
      case 500:
        return PrettyError('خطای سرور. کمی بعد تلاش کنید.', statusCode: status);
      default:
        return PrettyError('خطای شبکه: ${error.message}', statusCode: status);
    }
  }
  return PrettyError('خطای ناشناخته.');
}
