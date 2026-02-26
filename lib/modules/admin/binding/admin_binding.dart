import 'package:get/get.dart';
import '../../../core/services/api_service.dart';
import '../repository/admin_repository.dart';
import '../repository/admin_repository_impl.dart';
import '../controller/admin_controller.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminRepository>(
      () => AdminRepositoryImpl(Get.find<ApiService>()),
    );
    Get.lazyPut<AdminController>(() => AdminController(Get.find()));
  }
}
