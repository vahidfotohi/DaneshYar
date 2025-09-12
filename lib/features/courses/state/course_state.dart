import '../model/popular/popular_courses_model.dart';

class CourseState {
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final List<PopularCoursesModel> courses;

  const CourseState({
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
    this.courses = const [],
  });

  factory CourseState.initial() {
    return const CourseState(
      isLoading: false,
      hasError: false,
      errorMessage: null,
      courses: [],
    );
  }

  CourseState copyWith({
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    List<PopularCoursesModel>? courses,
  }) {
    return CourseState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      courses: courses ?? this.courses,
    );
  }
}
