class ApiEndpoints {

  static const String baseUrl = 'https://cypher.shirzadpic.com/api';
  static const String sendOtp = '/client/sendCode';
  static const String verifyOtp = '/client/login';

  static String full(String endpoint) {
    return '$baseUrl$endpoint';
  }
}
