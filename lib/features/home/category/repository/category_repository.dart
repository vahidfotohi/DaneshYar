import 'package:daneshyar/core/network/api_client.dart';
import 'package:daneshyar/core/network/error_mapper.dart';
import 'package:daneshyar/features/home/category/model/category_model.dart';
import 'package:dio/dio.dart';

class CategoryRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final categories = await _apiClient.categoryService.getAllCategories();
      return categories;
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      rethrow;
    }
  }
}
