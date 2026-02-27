import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/task_controller.dart';
import '../../auth/controller/auth_controller.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  final TaskController controller = Get.find<TaskController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.fetchUsers(role: 'developer');
    });
  }

  @override
  Widget build(BuildContext context) {
    final projectId = Get.arguments?["projectId"] ?? "";

    return Scaffold(
      appBar: AppBar(title: const Text("Create Task"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Task Details",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: controller.titleController,
              decoration: const InputDecoration(
                labelText: "Task Title",
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Description",
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (authController.isLoading.value &&
                  authController.users.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Assign Developer",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  helperText: "Select the developer for this task",
                ),
                value: controller.developerIdController.text.isNotEmpty
                    ? controller.developerIdController.text
                    : null,
                items: authController.users.map<DropdownMenuItem<String>>((
                  user,
                ) {
                  return DropdownMenuItem<String>(
                    value: user.id,
                    child: Text(user.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.developerIdController.text = value;
                  }
                },
              );
            }),
            const SizedBox(height: 16),
            TextField(
              controller: controller.hourlyRateController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: "Hourly Rate (\$)",
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton.icon(
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.createTask(projectId),
                  icon: controller.isLoading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.add_task),
                  label: const Text("Create Task"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
