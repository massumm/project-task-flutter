import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_task_flutter/modules/auth/views/register_view.dart';
import '../../../core/widgets/base_view.dart';
import '../controller/auth_controller.dart';

class LoginView extends BaseView<AuthController> {
  const LoginView({super.key});

  @override
  Widget body(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "Login",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

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
                    : controller.login,
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Login"),
              ),
            )),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () => Get.to(() => const RegisterView()),
              child: const Text("Don't have an account? Register"),
            )
          ],
        ),
      ),
    );
  }
}