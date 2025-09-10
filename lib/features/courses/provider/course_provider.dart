import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/network_providers.dart';
import '../state/course_state.dart';
import '../viewmodel/course_viewmodel.dart';

final courseProvider = StateNotifierProvider<CourseViewmodel, CourseState>((ref,){
  final repository = ref.watch(courseRepositoryProvider);
  return CourseViewmodel(repository);
});
