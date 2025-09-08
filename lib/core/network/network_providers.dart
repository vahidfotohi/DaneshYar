import 'package:daneshyar/features/home/courses/repository/course_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/home/home_repository/home_repository.dart';
import 'api_client.dart';
import 'package:daneshyar/features/authentication/auth/repository/auth_repository.dart';
import 'package:daneshyar/features/home/category/repository/category_repository.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

// ۲. Provider برای AuthRepository:
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRepository(apiClient);
});

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CategoryRepository(apiClient);
});

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return HomeRepository(apiClient);
});

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CourseRepository(apiClient);
});
