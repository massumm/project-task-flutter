import 'package:get/get.dart';
import '../../../core/services/api_service.dart';
import '../../payment/repository/payment_repository.dart';
import '../../payment/repository/payment_repository_impl.dart';
import '../repository/task_repository.dart';
import '../repository/task_repository_impl.dart';
import '../controller/task_controller.dart';

class TaskBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ApiService>()) {
      Get.put<ApiService>(ApiService());
    }
    Get.lazyPut<TaskRepository>(
      () => TaskRepositoryImpl(Get.find<ApiService>()),
    );
    if (!Get.isRegistered<PaymentRepository>()) {
      Get.lazyPut<PaymentRepository>(
        () => PaymentRepositoryImpl(Get.find<ApiService>()),
      );
    }
    Get.lazyPut<TaskController>(() => TaskController(Get.find()));
  }
}
