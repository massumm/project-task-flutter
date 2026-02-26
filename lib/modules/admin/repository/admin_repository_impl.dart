import '../../../core/config/api_config.dart';
import '../../../core/services/api_service.dart';
import 'admin_repository.dart';

class AdminRepositoryImpl implements AdminRepository {
  final ApiService api;

  AdminRepositoryImpl(this.api);

  @override
  Future<Map<String, dynamic>> getStats() async {
    final response = await api.get(ApiConfig.adminStats);
    return response.data;
  }
}
