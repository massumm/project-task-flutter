import 'package:dio/dio.dart';
import '../config/api_config.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<Response> post(String path, Map<String, dynamic> data) {
    return _dio.post(path, data: data);
  }

  Future<Response> get(String path) async {
    return await  _dio.get(path);
  }
}