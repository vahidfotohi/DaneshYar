
import '../model/category_model.dart';

class CategoryState {
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final List<CategoryModel> categories;

  const CategoryState({
    required this.isLoading,
    required this.hasError,
    this.errorMessage,
    required this.categories,
  });

  factory CategoryState.initial() {
    return const CategoryState(
      isLoading: false,
      hasError: false,
      errorMessage: null,
      categories: [],
    );
  }

  CategoryState copyWith({
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    List<CategoryModel>? categories,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
    );
  }
}