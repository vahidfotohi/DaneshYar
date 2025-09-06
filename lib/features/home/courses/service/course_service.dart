import 'package:daneshyar/core/constants/api_endpoints.dart';
import 'package:daneshyar/features/home/courses/model/course_response.dart';
import 'package:dio/dio.dart';

class CourseService {
  final Dio _dio;
  CourseService(this._dio);


  Future<CourseResponse> getAllCourses() async {
    try {
      final response = await _dio.get(ApiEndpoints.home);

      return CourseResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}