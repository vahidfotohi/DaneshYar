import 'package:daneshyar/features/home/courses/state/course_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/course_repository.dart';
import '../viewmodel/course_viewmodel.dart';

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  return CourseRepository();
});

final courseProvider =
    StateNotifierProvider<CourseViewmodel, CourseState>((ref) {
      final repository = ref.watch(courseRepositoryProvider);
      return CourseViewmodel(repository);
    });
