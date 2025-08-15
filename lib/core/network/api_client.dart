import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'auth_interceptor.dart';
import 'token_storage.dart';
import '../auth/auth_service.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio dio;
  late final Dio _authlessDio;
  late final TokenStorage _storage;
  late final AuthService _authService;

  ApiClient._internal() {
    _storage = SecureTokenStorage();

    _authlessDio = Dio(
      BaseOptions(
        baseUrl: 'https://cypher.shirzadpic.com/api/',
        headers: {'Accept': 'application/json'},
        connectTimeout: const Duration(seconds: 25),
        receiveTimeout: const Duration(seconds: 25),
        sendTimeout: const Duration(seconds: 25),
      ),
    );

    _authService = AuthService(
      authLessDio: _authlessDio,
      storage: _storage,
    );

    dio = Dio(
      BaseOptions(
        baseUrl: 'https://cypher.shirzadpic.com/api/',
        headers: {'Accept': 'application/json'},
        connectTimeout: const Duration(seconds: 25),
        receiveTimeout: const Duration(seconds: 25),
        sendTimeout: const Duration(seconds: 25),
      ),
    );

    // لاگ فقط در Debug
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
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


  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? query, Options? options}) {
    return dio.get<T>(path, queryParameters: query, options: options);
  }

  Future<Response<T>> post<T>(String path,
      {dynamic data, Map<String, dynamic>? query, Options? options}) {
    return dio.post<T>(path, data: data, queryParameters: query, options: options);
  }
}
