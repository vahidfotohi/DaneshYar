import 'package:daneshyar/features/home/model/home_response.dart';
import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';

class HomeService {
  final Dio _dio;

  HomeService(this._dio);

  Future<HomeResponse> getHomeData() async {
    try {
      final response = await _dio.get(ApiEndpoints.home);
      return HomeResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
