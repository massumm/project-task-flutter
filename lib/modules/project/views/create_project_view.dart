import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/project_controller.dart';

class CreateProjectView extends StatelessWidget {
  CreateProjectView({super.key});

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProjectController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Create Project")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            Obx(() {
              return controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.createProject(
                      titleController.text.trim(),
                      descriptionController.text.trim(),
                    );
                  },
                  child: const Text("Create"),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}