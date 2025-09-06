import 'package:daneshyar/core/network/api_client.dart';
import 'package:daneshyar/core/network/error_mapper.dart';
import 'package:daneshyar/features/home/courses/model/course_model.dart';
import 'package:dio/dio.dart';

class CourseRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<CourseModel>> getAllCourses() async {
    try {
      final response = await _apiClient.courseService.getAllCourses();
      if(response.status){
        return response.data.map((course) {
          Suggested suggestedCourse = Suggested.none;
          if(course.flagPublished == "1"){
            suggestedCourse = Suggested.suggested;
          }

          return CourseModel(
            id: course.id.toString(),
            title: course.title,
            isMarked: false,
            price: course.price,
            offerPrice: course.discountPrice?.toString(),
            cover: "storage/${course.cover}",
            suggested: suggestedCourse,
            mentorName: course.mentor.name,
            star: '4.5'
          );
        },).toList();
      }else{
        throw Exception(response.errorMessage ?? "خطا در دریافت دوره ها");
      }
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      rethrow;
    }
  }
}
