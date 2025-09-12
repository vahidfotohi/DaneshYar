import 'package:daneshyar/core/network/api_client.dart';
import 'package:daneshyar/core/network/error_mapper.dart';
import 'package:dio/dio.dart';

import '../model/base/course_info.dart';
import '../model/popular/popular_courses_model.dart';

class CourseRepository {
  final ApiClient _apiClient;

  CourseRepository(this._apiClient);

  Future<List<PopularCoursesModel>> getAllCourses() async {
    try {
      final response = await _apiClient.courseService.getAllCourses();
      if (response.status) {
        return response.data.map((course) {
          Suggested suggestedCourse = Suggested.none;
          if (course.flagPublished == "1") {
            suggestedCourse = Suggested.suggested;
          }

          return PopularCoursesModel(
            courseInfo: CourseInfo(
              id: course.id,
              title: course.title,
              cover: course.cover,
              mentorName: course.mentor.name,
              isMarked: false,
            ),
            price: course.price,
            suggested: suggestedCourse,
            offerPrice: course.price,
            star: "4.6",
          );
        }).toList();
      } else {
        throw Exception(response.errorMessage ?? "خطا در دریافت دوره ها");
      }
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      rethrow;
    }
  }
}
