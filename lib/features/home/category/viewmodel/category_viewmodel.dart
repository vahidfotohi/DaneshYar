import 'package:daneshyar/features/home/category/state/category_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/category_repository.dart';

class CategoryViewmodel extends StateNotifier<CategoryState> {
  final CategoryRepository _categoryRepository;
  CategoryViewmodel(this._categoryRepository) : super(CategoryState.initial());

  Future<void> fetchCategories() async {
    state = state.copyWith(isLoading: true , hasError: false);
   try{
     final categories = await _categoryRepository.getAllCategories();
      state = state.copyWith(isLoading: false , hasError: false , categories: categories);
      }catch(e){
     state = state.copyWith(isLoading: false,hasError: true,errorMessage: e.toString());
   }


  }
}
