import 'package:daneshyar/features/authentication/user/model/user_model.dart';
import 'package:daneshyar/features/category/model/category_model.dart';
import 'package:daneshyar/features/mentor/model/mentor_model.dart';
import '../../courses/model/popular/popular_courses_model.dart';

class CleanHomeData {
  final UserModel user;
  final List<CategoryModel> categories;
  final List<PopularCoursesModel> popularCourses;
  final List<MentorModel> mentors;

  CleanHomeData({
    required this.user,
    required this.categories,
    required this.popularCourses,
    required this.mentors,
  });

  factory CleanHomeData.initial() {
    return CleanHomeData(
      user: UserModel.initial(),
      categories: [],
      popularCourses: [],
      mentors: [],
    );
  }
}
