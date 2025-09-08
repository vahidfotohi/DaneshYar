import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static final String baseUrl = dotenv.env['BASE_URL']!;

  static const String sendOtp = '/client/sendCode';
  static const String verifyOtp = '/client/login';
  static const String refreshToken = '/client/refresh';
  static const String completeProfile = '/client/register';
  static const String categories = '/category';
  static const String categoriesCourses = '/category/courses';
  static const String home = '/main';



  static String full(String endpoint) {
    return '$baseUrl$endpoint';
  }
}
