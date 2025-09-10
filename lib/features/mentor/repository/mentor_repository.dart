import 'package:daneshyar/core/network/api_client.dart';
import 'package:daneshyar/core/network/error_mapper.dart';
import 'package:daneshyar/features/mentor/model/mentor_request.dart';
import 'package:dio/dio.dart';

import '../model/mentor_model.dart';

class MentorRepository {

  final ApiClient _apiClient;

  MentorRepository(this._apiClient);


  Future<MentorModel> getMentorById(int mentorId) async {
    try {
      final request = MentorRequest(mentorId: mentorId);
      final response = await _apiClient.mentorService.getMentorById(request);
      if (response.status) {
        return response.data;
      } else {
        throw Exception(response.errorMessage ?? "خطا در دریافت مربیان");
      }
    }on DioException catch(e){
      throw mapDioError(e);
    } catch (e) {
      rethrow;
    }
  }
}