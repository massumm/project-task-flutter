import '../../../core/config/api_config.dart';
import '../../../core/services/api_service.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final ApiService api;
  AuthRepositoryImpl(this.api);

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await api.post(ApiConfig.login, {
      "email": email,
      "password": password,
    });
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String role,
  ) async {
    final response = await api.post(ApiConfig.register, {
      "name": name,
      "email": email,
      "password": password,
      "role": role,
    });
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getMe() async {
    final response = await api.get(ApiConfig.me);
    return response.data;
  }

  @override
  Future<List<dynamic>> fetchUsers({String? role}) async {
    final response = await api.get(
      ApiConfig.userlist,
      queryParameters: role != null ? {'role': role} : null,
    );
    return response.data;
  }
}
