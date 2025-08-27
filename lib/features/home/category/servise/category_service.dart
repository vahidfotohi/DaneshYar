import 'package:daneshyar/core/constants/api_endpoints.dart';
import 'package:daneshyar/features/home/category/model/category_model.dart';
import 'package:dio/dio.dart';

class CategoryService {
  final Dio _dio ;
  
  CategoryService(this._dio);
  
  Future<List<CategoryModel>> getAllCategories() async{
    try{
      final response = await _dio.get(ApiEndpoints.categories);
      final List<dynamic> jsonList = response.data['data'];

      final categories = jsonList.map((category) => CategoryModel.fromJson(category)).toList();

      return categories;
    }catch(e){
      rethrow;
    }
  }
}