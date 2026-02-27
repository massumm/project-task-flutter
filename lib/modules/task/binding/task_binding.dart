import 'package:get/get.dart';
import 'package:project_task_flutter/modules/auth/controller/auth_controller.dart';
import 'package:project_task_flutter/modules/auth/repositories/auth_repository.dart';
import 'package:project_task_flutter/modules/auth/repositories/auth_repository_impl.dart';
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
      Get.put<ApiService>(ApiService(), permanent: true);
    }
    if (!Get.isRegistered<AuthRepository>()) {
      Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(Get.find<ApiService>()),
      );
    }
    if (!Get.isRegistered<AuthController>()) {
      Get.lazyPut<AuthController>(
        () => AuthController(Get.find<AuthRepository>()),
      );
    }
    if (!Get.isRegistered<TaskRepository>()) {
      Get.lazyPut<TaskRepository>(
        () => TaskRepositoryImpl(Get.find<ApiService>()),
      );
    }
    if (!Get.isRegistered<PaymentRepository>()) {
      Get.lazyPut<PaymentRepository>(
        () => PaymentRepositoryImpl(Get.find<ApiService>()),
      );
    }
    if (!Get.isRegistered<TaskController>()) {
      Get.lazyPut<TaskController>(() => TaskController(Get.find()));
    }
  }
}
