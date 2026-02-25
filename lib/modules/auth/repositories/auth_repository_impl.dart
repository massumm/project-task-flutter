import '../../../core/config/api_config.dart';
import '../../../core/services/api_service.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final ApiService api;
  AuthRepositoryImpl(this.api);

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
  print("asdf"+email+password+ApiConfig.login);
   final response= await api.post(ApiConfig.login, {
      "email": email,
      "password": password,
    });

   print("asdf"+response.toString());

   return response.data;
  }

  @override
  Future<Map<String, dynamic>> register(String email, String password) async {

    final response= await api.post(ApiConfig.login, {
      "email": email,
      "password": password,
    });

    return response.data;
  }

}