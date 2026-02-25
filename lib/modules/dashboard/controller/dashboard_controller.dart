import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../auth/controller/auth_controller.dart';

class DashboardController extends GetxController {
  final box = GetStorage();

  var role = "".obs;

  @override
  void onInit() {
    role.value = box.read("role") ?? "";
    super.onInit();
  }

  void logout() {
    Get.find<AuthController>().logout();
  }
}