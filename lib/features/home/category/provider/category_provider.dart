import 'package:daneshyar/features/home/category/state/category_state.dart';
import 'package:daneshyar/features/home/category/viewmodel/category_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/category_repository.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepository();
});

final categoryProvider =
    StateNotifierProvider<CategoryViewmodel, CategoryState>((ref) {
      final repository = ref.watch(categoryRepositoryProvider);
      return CategoryViewmodel(repository)..fetchCategories();
    });
