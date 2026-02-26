import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../model/task_model.dart';
import '../repository/task_repository.dart';

class TaskController extends GetxController {
  final TaskRepository repository;

  TaskController(this.repository);

  var isLoading = false.obs;
  var tasks = <TaskModel>[].obs;
  var currentTask = Rxn<TaskModel>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final developerIdController = TextEditingController();
  final hourlyRateController = TextEditingController();
  final hoursSpentController = TextEditingController();

  String get role => GetStorage().read("role") ?? "";

  Future<void> fetchProjectTasks(String projectId) async {
    try {
      isLoading.value = true;
      tasks.value = await repository.getProjectTasks(projectId);
    } catch (e) {
      Get.snackbar("Error", "Failed to load tasks: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTask(String taskId) async {
    try {
      isLoading.value = true;
      currentTask.value = await repository.getTask(taskId);
    } catch (e) {
      Get.snackbar("Error", "Failed to load task: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createTask(String projectId) async {
    try {
      isLoading.value = true;
      await repository.createTask(
        projectId: projectId,
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        assignedDeveloper: developerIdController.text.trim(),
        hourlyRate: double.parse(hourlyRateController.text.trim()),
      );
      clearFields();
      Get.back();
      Get.snackbar("Success", "Task created");
      fetchProjectTasks(projectId);
    } catch (e) {
      Get.snackbar("Error", "Failed to create task: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> startTask(String taskId) async {
    try {
      isLoading.value = true;
      currentTask.value = await repository.startTask(taskId);
      Get.snackbar("Success", "Task started");
    } catch (e) {
      Get.snackbar("Error", "Failed to start task: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitTask(String taskId) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['zip'],
      );

      if (result == null || result.files.isEmpty) {
        Get.snackbar("Error", "Please select a ZIP file");
        return;
      }

      final hours = double.tryParse(hoursSpentController.text.trim());
      if (hours == null || hours <= 0) {
        Get.snackbar("Error", "Please enter valid hours spent");
        return;
      }

      isLoading.value = true;

      final file = result.files.first;
      final formData = dio.FormData.fromMap({
        "hours_spent": hours,
        "file": await dio.MultipartFile.fromFile(
          file.path!,
          filename: file.name,
        ),
      });

      currentTask.value = await repository.submitTask(taskId, hours, formData);
      Get.snackbar("Success", "Task submitted successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to submit task: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    developerIdController.clear();
    hourlyRateController.clear();
    hoursSpentController.clear();
  }
}
