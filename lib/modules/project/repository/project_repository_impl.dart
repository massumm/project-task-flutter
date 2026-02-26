import 'package:project_task_flutter/core/config/api_config.dart';
import 'package:project_task_flutter/modules/project/repository/project_repository.dart';

import '../../../core/services/api_service.dart';
import '../model/project_model.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ApiService api;

  ProjectRepositoryImpl(this.api);

  @override
  Future<List<ProjectModel>> getProjects() async {
    final response = await api.get(ApiConfig.myProjects);

    return (response.data as List)
        .map((e) => ProjectModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> createProject(String title, String description) async {
    await api.post(ApiConfig.projects, {
      "title": title,
      "description": description,
    });
  }
}
