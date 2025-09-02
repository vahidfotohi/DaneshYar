import 'package:daneshyar/core/constants/api_endpoints.dart';
import 'package:daneshyar/features/home/category/model/category_model.dart';
import 'package:daneshyar/features/home/category/model/category_response.dart';
import 'package:dio/dio.dart';

class CategoryService {
  final Dio _dio ;
  
  CategoryService(this._dio);
  
  Future<CategoryResponse> getAllCategories() async{
    try{
      final response = await _dio.get(ApiEndpoints.categories);


      return CategoryResponse.fromJson(response.data);
    }catch(e){
      rethrow;
    }
  }
}