import 'package:daneshyar/core/constants/api_endpoints.dart';
import 'package:daneshyar/features/home/category/servise/category_service.dart';
import 'package:daneshyar/features/home/courses/service/course_service.dart';
import 'package:daneshyar/features/home/service/home_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../features/authentication/auth/service/auth_service.dart';
import 'auth_interceptor.dart';
import 'token_storage.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() => _instance;

  late final Dio dio;
  late final Dio _authlessDio;
  late final TokenStorage _storage;
  late final AuthService _authService;
  late final CategoryService _categoryService;
  late final CourseService _courseService;
  late final HomeService _homeService;

  ApiClient._internal() {
    _storage = SecureTokenStorage();

    _authlessDio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        headers: {'content-type': 'application/json'},
        connectTimeout: const Duration(seconds: 25),
        receiveTimeout: const Duration(seconds: 25),
        sendTimeout: const Duration(seconds: 25),
      ),
    );
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        headers: {'content-type': 'application/json'},
        connectTimeout: const Duration(seconds: 25),
        receiveTimeout: const Duration(seconds: 25),
        sendTimeout: const Duration(seconds: 25),
      ),
    );

    _authService = AuthService(
      dio: dio,
      authLessDio: _authlessDio,
      storage: _storage,
    );

    _categoryService = CategoryService(dio);
    _courseService = CourseService(dio);
    _homeService = HomeService(dio);

    // لاگ فقط در Debug
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }

    dio.interceptors.add(
      AuthInterceptor(storage: _storage, authService: _authService),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.extra['dio_instance'] = dio;
          handler.next(options);
        },
      ),
    );
  }

  TokenStorage get tokenStorage => _storage;

  AuthService get authService => _authService;

  CategoryService get categoryService => _categoryService;
  CourseService get courseService => _courseService;
  HomeService get homeService => _homeService;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    Options? options,
  }) {
    return dio.get<T>(path, queryParameters: query, options: options);
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    Options? options,
  }) {
    return dio.post<T>(
      path,
      data: data,
      queryParameters: query,
      options: options,
    );
  }

  Future<Response<T>> put<T>(String path, {dynamic data, Options? options}) =>
      dio.put<T>(path, data: data, options: options);

  Future<Response<T>> delete<T>(
    String path, {
    Map<String, dynamic>? query,
    Options? options,
  }) => dio.delete<T>(path, queryParameters: query, options: options);
}
