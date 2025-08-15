import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';

class HomeService {
  final Dio _dio = ApiClient().dio;

  Future<List<dynamic>> fetchItems() async {
    final res = await _dio.get('/home/items');
    // فرض: پاسخ یک آرایه JSON است
    return (res.data as List).cast<dynamic>();
  }
}
