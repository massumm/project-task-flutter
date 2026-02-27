import 'package:get/get.dart';
import '../../../core/services/api_service.dart';
import '../repository/project_repository.dart';
import '../repository/project_repository_impl.dart';
import '../controller/project_controller.dart';

class ProjectBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ApiService>()) {
      Get.put<ApiService>(ApiService(), permanent: true);
    }
    Get.lazyPut<ProjectRepository>(
      () => ProjectRepositoryImpl(Get.find<ApiService>()),
    );
    Get.lazyPut<ProjectController>(() => ProjectController(Get.find()));
  }
}
