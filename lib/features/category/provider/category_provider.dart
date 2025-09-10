import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/network_providers.dart';
import '../state/category_state.dart';
import '../viewmodel/category_viewmodel.dart';

final categoryProvider =
    StateNotifierProvider<CategoryViewmodel, CategoryState>((ref) {
      final repository = ref.watch(categoryRepositoryProvider);
      return CategoryViewmodel(repository);
    });
