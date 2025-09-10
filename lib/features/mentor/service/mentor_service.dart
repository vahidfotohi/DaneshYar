import 'package:daneshyar/core/constants/api_endpoints.dart';
import 'package:daneshyar/features/mentor/model/mentor_request.dart';
import 'package:daneshyar/features/mentor/model/mentor_response.dart';
import 'package:dio/dio.dart';

class MentorService {
  final Dio _dio;

  MentorService(this._dio);

  Future<dynamic> getMentorById(MentorRequest request) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.mentorDetails,
        data: request.toJson(),
      );
      return MentorResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
