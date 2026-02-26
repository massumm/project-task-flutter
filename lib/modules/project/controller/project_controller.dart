import 'package:get/get.dart';
import '../repository/project_repository.dart';
import '../model/project_model.dart';

class ProjectController extends GetxController {
  final ProjectRepository repository;

  ProjectController(this.repository);

  var isLoading = false.obs;
  var projects = <ProjectModel>[].obs;

  @override
  void onInit() {
    fetchProjects();
    super.onInit();
  }

  Future<void> fetchProjects() async {
    try {
      isLoading.value = true;
      projects.value = await repository.getProjects();
    } catch (e) {
      Get.snackbar("Error", "Failed to load projects: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createProject(String title, String description) async {
    try {
      isLoading.value = true;
      await repository.createProject(title, description);
      Get.back();
      Get.snackbar("Success", "Project Created");
      fetchProjects();
    } catch (e) {
      Get.snackbar("Error", "Failed to create project: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
