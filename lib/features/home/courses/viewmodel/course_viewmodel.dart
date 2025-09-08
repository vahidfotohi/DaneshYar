import 'package:daneshyar/features/home/courses/model/course_model.dart';
import 'package:daneshyar/features/home/courses/state/course_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/course_repository.dart';

class CourseViewmodel extends StateNotifier<CourseState> {
  final CourseRepository repository;

  CourseViewmodel(this.repository) : super(CourseState.initial());

  void initializeData(List<CourseModel> courses) {
    state = state.copyWith(courses: courses, isLoading: false, hasError: false);
  }

  Future<void> fetchCourses() async {
    state = state.copyWith(isLoading: true);
    try {
      final courses = await repository.getAllCourses();
      state = state.copyWith(courses: courses, isLoading: false);
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching courses: $e");
      }
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  List<CourseModel> get popularCourses => state.courses
      .where((course) => course.suggested == Suggested.suggested)
      .toList();

  void refresh() {
    fetchCourses();
  }
}
