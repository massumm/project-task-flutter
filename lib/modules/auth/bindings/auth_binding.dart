import 'package:get/get.dart';
import 'package:project_task_flutter/core/services/api_service.dart';
import 'package:project_task_flutter/modules/auth/repositories/auth_repository.dart';
import 'package:project_task_flutter/modules/auth/repositories/auth_repository_impl.dart';
import '../controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    Get.lazyPut<AuthController>(() => AuthController(Get.find()));
  }
}
