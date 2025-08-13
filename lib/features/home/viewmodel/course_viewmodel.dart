import 'package:daneshyar/features/home/model/course_model.dart';
import 'package:daneshyar/features/home/repository/course_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseViewmodel extends StateNotifier<List<CourseModel>> {
  final CourseRepository repository;

  CourseViewmodel(this.repository) : super([]) {
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      final courses = await repository.fetchCourses();
      state = courses;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching courses: $e");
      }
    }
  }

  List<CourseModel> getPopularCourses() {
    return state
        .where(
          (course) =>
              (course.suggested == Suggested.suggested ||
              course.suggested == Suggested.bestseller),
        )
        .toList();
  }

  void refresh(){
    fetchCourses();
  }
}
