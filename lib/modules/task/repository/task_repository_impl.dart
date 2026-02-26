import 'package:dio/dio.dart' as dio;
import '../../../core/config/api_config.dart';
import '../../../core/services/api_service.dart';
import '../model/task_model.dart';
import 'task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final ApiService api;

  TaskRepositoryImpl(this.api);

  @override
  Future<List<TaskModel>> getProjectTasks(String projectId) async {
    final response = await api.get(ApiConfig.projectTasks(projectId));
    return (response.data as List).map((e) => TaskModel.fromJson(e)).toList();
  }

  @override
  Future<TaskModel> getTask(String taskId) async {
    final response = await api.get(ApiConfig.taskDetail(taskId));
    return TaskModel.fromJson(response.data);
  }

  @override
  Future<TaskModel> createTask({
    required String projectId,
    required String title,
    required String description,
    required String assignedDeveloper,
    required double hourlyRate,
  }) async {
    final response = await api.post(ApiConfig.tasks, {
      "project_id": projectId,
      "title": title,
      "description": description,
      "assigned_developer": assignedDeveloper,
      "hourly_rate": hourlyRate,
    });
    return TaskModel.fromJson(response.data);
  }

  @override
  Future<TaskModel> startTask(String taskId) async {
    final response = await api.post(ApiConfig.startTask(taskId), {});
    return TaskModel.fromJson(response.data);
  }

  @override
  Future<TaskModel> submitTask(
    String taskId,
    double hoursSpent,
    dio.FormData formData,
  ) async {
    final response = await api.postMultipart(
      ApiConfig.submitTask(taskId),
      formData,
    );
    return TaskModel.fromJson(response.data);
  }
}
