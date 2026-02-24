import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_task_flutter/modules/auth/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository repository;
  AuthController(this.repository);
  var isLoading=false.obs;

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final nameController = TextEditingController().obs;

  final box = GetStorage();

  Future<void> login()async {
    try {
      print("object"+emailController.value.text+passwordController.value.text);
      isLoading.value = true;
      final response = repository.login(emailController.value.text, passwordController.value.text);
      print("object"+response.toString());
      box.write("token", response["access_token"]);
      box.write("role", response["role"]);
    }finally{
      isLoading.value = false;
    }
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