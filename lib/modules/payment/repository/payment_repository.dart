import '../model/payment_model.dart';

abstract class PaymentRepository {
  Future<PaymentModel> payForTask(String taskId);
}
