import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../config/api_config.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  ApiService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = GetStorage().read("token");
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> post(String path, Map<String, dynamic> data) {
    return _dio.post(path, data: data);
  }

  Future<Response> get(String path) async {
    return await _dio.get(path);
  }

  Future<Response> put(String path, Map<String, dynamic> data) {
    return _dio.put(path, data: data);
  }

  Future<Response> patch(String path, Map<String, dynamic> data) {
    return _dio.patch(path, data: data);
  }

  Future<Response> delete(String path) {
    return _dio.delete(path);
  }

  Future<Response> postMultipart(String path, FormData formData) {
    return _dio.post(path, data: formData);
  }
}
