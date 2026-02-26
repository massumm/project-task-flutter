import '../../../core/config/api_config.dart';
import '../../../core/services/api_service.dart';
import '../model/payment_model.dart';
import 'payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final ApiService api;

  PaymentRepositoryImpl(this.api);

  @override
  Future<PaymentModel> payForTask(String taskId) async {
    final response = await api.post(ApiConfig.payForTask(taskId), {});
    return PaymentModel.fromJson(response.data);
  }
}
