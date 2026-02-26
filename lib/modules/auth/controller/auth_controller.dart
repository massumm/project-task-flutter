import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_task_flutter/modules/auth/repositories/auth_repository.dart';
import 'package:project_task_flutter/routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthRepository repository;
  AuthController(this.repository);

  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final selectedRole = "buyer".obs;

  final box = GetStorage();

  Future<void> login() async {
    try {
      isLoading.value = true;
      final response = await repository.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      box.write("token", response["access_token"]);
      box.write("role", response["role"]);

      Get.snackbar("Success", "Login Successful");
      Get.offAllNamed(AppRoutes.dashboard);
    } catch (e) {
      Get.snackbar("Error", "Login failed: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    box.erase();
    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> register() async {
    try {
      isLoading.value = true;
      await repository.register(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
        selectedRole.value,
      );

      Get.snackbar("Success", "Registration Successful. Please login.");
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar("Error", "Registration failed: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
