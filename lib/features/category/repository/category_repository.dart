import 'package:daneshyar/core/constants/api_endpoints.dart';
import 'package:daneshyar/core/network/api_client.dart';
import 'package:daneshyar/core/network/error_mapper.dart';
import 'package:dio/dio.dart';
import '../model/category_model.dart';

class CategoryRepository {
  final ApiClient _apiClient;

  CategoryRepository(this._apiClient);

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final response = await _apiClient.categoryService.getAllCategories();
      if (response.status == true) {
        final categories = response.data
            .map(
              (dataItem) => CategoryModel(
                id: dataItem.id,
                title: dataItem.title,
                icon: "${ApiEndpoints.baseUrl}/storage/${dataItem.icon}",
              ),
            )
            .toList();
        return categories;
      } else {
        throw Exception(response.errorMessage ?? "خطا در دریافت دسته بندی ها");
      }
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      rethrow;
    }
  }
}
