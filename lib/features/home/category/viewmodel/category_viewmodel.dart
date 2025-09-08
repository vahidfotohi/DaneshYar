import 'package:daneshyar/features/home/category/model/category_model.dart';
import 'package:daneshyar/features/home/category/state/category_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/category_repository.dart';

class CategoryViewmodel extends StateNotifier<CategoryState> {
  final CategoryRepository _categoryRepository;
  CategoryViewmodel(this._categoryRepository) : super(CategoryState.initial());
  void initializeData(List<CategoryModel> categories){
    state = state.copyWith(categories: categories , isLoading: false , hasError: false);
  }
  Future<void> fetchCategories() async {
    if(state.categories.isNotEmpty) return;
    state = state.copyWith(isLoading: true , hasError: false);
   try{
     final categories = await _categoryRepository.getAllCategories();
      state = state.copyWith(isLoading: false , hasError: false , categories: categories);
      }catch(e){
     state = state.copyWith(isLoading: false,hasError: true,errorMessage: e.toString());
   }


  }
}
