import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/services/api_service.dart';
import '../../admin/binding/admin_binding.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/repositories/auth_repository.dart';
import '../../auth/repositories/auth_repository_impl.dart';
import '../../payment/repository/payment_repository.dart';
import '../../payment/repository/payment_repository_impl.dart';
import '../controller/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure ApiService is available
    if (!Get.isRegistered<ApiService>()) {
      Get.put<ApiService>(ApiService(), permanent: true);
    }

    // Auth (needed for logout)
    if (!Get.isRegistered<AuthRepository>()) {
      Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(Get.find<ApiService>()),
      );
    }
    if (!Get.isRegistered<AuthController>()) {
      Get.lazyPut<AuthController>(() => AuthController(Get.find()));
    }

    // Payment
    Get.lazyPut<PaymentRepository>(
      () => PaymentRepositoryImpl(Get.find<ApiService>()),
    );

    // Dashboard
    Get.lazyPut<DashboardController>(() => DashboardController());

    // Admin (conditionally bind if admin)
    final role = GetStorage().read("role") ?? "";
    if (role == "admin") {
      AdminBinding().dependencies();
    }
  }
}
