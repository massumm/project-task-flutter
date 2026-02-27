import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_routes.dart';

class DashboardController extends GetxController {
  final box = GetStorage();

  var role = "".obs;

  @override
  void onInit() {
    role.value = box.read("role") ?? "";
    super.onInit();
  }

  void logout() {
    box.erase();
    Get.offAllNamed(AppRoutes.login);
  }
}
