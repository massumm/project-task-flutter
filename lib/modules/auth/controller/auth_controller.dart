import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_task_flutter/modules/auth/repositories/auth_repository.dart';
import 'package:project_task_flutter/routes/app_pages.dart';
import 'package:project_task_flutter/routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthRepository repository;
  AuthController(this.repository);
  var isLoading=false.obs;

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final nameController = TextEditingController().obs;

  final box = GetStorage();

  Future<void> login() async {
    try {
      isLoading.value = true;
      // ADD 'await' HERE
      final response = await repository.login(
          emailController.value.text,
          passwordController.value.text
      );

      print("Response data: $response");

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
    Get.offAllNamed("/login");
  }

  Future<void> register()async {
    try {
      isLoading.value = true;
      final data = repository.login(emailController.value.text, passwordController.value.text);
    }finally{
      isLoading.value = false;
    }
  }
}

extension on Future<Map<String, dynamic>> {
  operator [](String other) {}
}