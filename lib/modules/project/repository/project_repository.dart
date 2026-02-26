import '../model/project_model.dart';

abstract class ProjectRepository {
  Future<List<ProjectModel>> getProjects();
  Future<void> createProject(String title, String description);
}
