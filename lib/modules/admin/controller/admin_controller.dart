import 'package:get/get.dart';
import '../repository/admin_repository.dart';

class AdminController extends GetxController {
  final AdminRepository repository;

  AdminController(this.repository);

  var isLoading = false.obs;
  var stats = <String, dynamic>{}.obs;

  @override
  void onInit() {
    fetchStats();
    super.onInit();
  }

  Future<void> fetchStats() async {
    try {
      isLoading.value = true;
      stats.value = await repository.getStats();
    } catch (e) {
      Get.snackbar("Error", "Failed to load stats: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
