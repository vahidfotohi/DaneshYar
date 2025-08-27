class ApiEndpoints {

  static const String baseUrl = 'http://193.242.208.208:8080/api';
  static const String sendOtp = '/client/sendCode';
  static const String verifyOtp = '/client/login';
  static const String refreshToken = '/client/refresh';
  static const String completeProfile = '/client/register';
  static const String categories = '/category';


  static String full(String endpoint) {
    return '$baseUrl$endpoint';
  }
}
