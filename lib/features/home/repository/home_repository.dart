import 'package:daneshyar/core/network/api_client.dart';
import 'package:daneshyar/core/network/error_mapper.dart';
import 'package:daneshyar/features/authentication/user/model/user_model.dart';
import 'package:daneshyar/features/mentor/model/mentor_model.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart' as intl;
import '../../../core/constants/api_endpoints.dart';
import '../../category/model/category_model.dart';
import '../../courses/model/base/course_info.dart';
import '../../courses/model/popular/popular_courses_model.dart';
import '../model/clean_home_data.dart';

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
          avatar:
              '${ApiEndpoints.baseUrl}/storage/}${homeData.customer.avatar}',
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

        final popularCourses = homeData.courses.map((courseData) {
          final formatter = intl.NumberFormat.decimalPattern();
          String coursePrice = formatter
              .format(int.parse(courseData.price))
              .replaceAll(',', '/');
          final courseInfo = CourseInfo(
            id: courseData.id,
            title: courseData.title,
            cover: "${ApiEndpoints.baseUrl}/storage/${courseData.cover}",
            mentorName: courseData.mentor.name,
            isMarked: false,
          );

          return PopularCoursesModel(
            courseInfo: courseInfo,
            price: coursePrice,
            suggested: courseData.flagPublished == '1'
                ? Suggested.suggested
                : Suggested.none,
            offerPrice: courseData.discountPrice,
            star: '4.6',
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
          popularCourses: popularCourses,
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
