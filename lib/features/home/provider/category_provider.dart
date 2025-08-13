import 'package:daneshyar/features/home/model/category_model.dart';
import 'package:daneshyar/features/home/viewmodel/category_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryProvider =
    StateNotifierProvider<CategoryViewmodel, List<CategoryModel>>(
      (ref) => CategoryViewmodel()..fetchCategories(),
    );
