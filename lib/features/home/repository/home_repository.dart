import 'package:daneshyar/core/network/api_client.dart';
import 'package:daneshyar/core/network/error_mapper.dart';
import 'package:daneshyar/features/authentication/user/model/user_model.dart';
import 'package:daneshyar/features/mentor/model/mentor_model.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart' as intl;
import '../../../core/constants/api_endpoints.dart';
import '../../category/model/category_model.dart';
import '../../courses/model/course_model.dart';

class CleanHomeData {
  final UserModel user;
  final List<MentorModel> mentors;
  final List<CategoryModel> categories;
  final List<CourseModel> courses;

  CleanHomeData({
    required this.user,
    required this.categories,
    required this.courses,
    required this.mentors,
  });
}

class HomeRepository {
  final ApiClient _apiClient;

  HomeRepository(this._apiClient);

  Future<CleanHomeData> getHomeData() async {
    try {
      final response = await _apiClient.homeService.getHomeData();
      if (response.status == true && response.data != null) {
        final homeData = response.data!;

        final user = UserModel(
          id: homeData.customer.id.toString(),
          fullName: homeData.customer.fullname,
          phone: homeData.customer.phone,
          avatar: homeData.customer.avatar,
        );

        final categories = homeData.categories
            .map(
              (category) => CategoryModel(
                id: category.id.toString(),
                icon: "${ApiEndpoints.baseUrl}/storage/${category.icon}",
                title: category.title,
              ),
            )
            .toList();

        final courses = homeData.courses.map((course) {
          final formatter = intl.NumberFormat.decimalPattern();
          String coursePrice = formatter
              .format(int.parse(course.price))
              .replaceAll(',', '/');
          Suggested suggestedCourse = Suggested.none;
          if (course.flagPublished == "1") {
            suggestedCourse = Suggested.suggested;
          }
          return CourseModel(
            id: course.id.toString(),
            title: course.title,
            mentorName: course.mentor.name,
            cover: "${ApiEndpoints.baseUrl}/storage/${course.cover}",
            price: coursePrice,
            suggested: suggestedCourse,
            isMarked: false,
            offerPrice: course.discountPrice,
            star: '4.5',
          );
        }).toList();

        final mentors = homeData.mentors
            .map(
              (mentor) => MentorModel(
                id: mentor.id,
                name: mentor.name,
                avatar: "${ApiEndpoints.baseUrl}/storage/${mentor.avatar}",
                bio: mentor.bio!,
                phoneNumber: mentor.phoneNumber,
                wallet: mentor.wallet,
                iban: mentor.iban,
                creditName: mentor.creditName,
                creditNumber: mentor.creditNumber,
                description: mentor.description,
                verified: mentor.verified,
                active: mentor.active,
              ),
            )
            .toList();

        return CleanHomeData(
          courses: courses,
          categories: categories,
          user: user,
          mentors: mentors,
        );
      } else {
        throw Exception(response.errorMessage ?? 'خطا در دریافت اطلاعات ');
      }
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      rethrow;
    }
  }
}
