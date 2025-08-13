import 'package:daneshyar/features/home/repository/course_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/course_model.dart';
import '../viewmodel/course_viewmodel.dart';

final courseViewmodelProvider =
    StateNotifierProvider<CourseViewmodel, List<CourseModel>>((ref) {
      final repository = ref.read(CourseRepository().coursesRepositoryProvider);
      return CourseViewmodel(repository);
    });
