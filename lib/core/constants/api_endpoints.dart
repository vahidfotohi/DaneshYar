
class ApiEndpoints {
  static final String baseUrl =  'https://cypher.shirzadpic.com/api';

  static const String sendOtp = '/client/sendCode';
  static const String verifyOtp = '/client/login';
  static const String refreshToken = '/client/refresh';
  static const String completeProfile = '/client/register';
  static const String categories = '/category';
  static const String categoriesCourses = '/category/courses';
  static const String home = '/main';
  static const String courseDetails = '/course';
  static const String mentorDetails = '/mentor/getMentor';



  static String full(String endpoint) {
    return '$baseUrl$endpoint';
  }
}
