import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/base_view.dart';
import '../controller/auth_controller.dart';

class RegisterView extends BaseView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget body(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "Register",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: controller.nameController.value,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: controller.emailController.value,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: controller.passwordController.value,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            Obx(() => SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.register,
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Register"),
              ),
            )),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Already have an account? Login"),
            )
          ],
        ),
      ),
    );
  }
}