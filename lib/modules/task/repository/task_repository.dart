import 'package:dio/dio.dart' as dio;
import '../model/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getProjectTasks(String projectId);
  Future<TaskModel> getTask(String taskId);
  Future<TaskModel> createTask({
    required String projectId,
    required String title,
    required String description,
    required String assignedDeveloper,
    required double hourlyRate,
  });
  Future<TaskModel> startTask(String taskId);
  Future<TaskModel> submitTask(
    String taskId,
    double hoursSpent,
    dio.FormData formData,
  );
}
