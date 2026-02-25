import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../project/controller/project_controller.dart';
import '../controller/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final projectController = Get.find<ProjectController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Obx(() {
        if (projectController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (projectController.projects.isEmpty) {
          return const Center(child: Text("No Projects Found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: projectController.projects.length,
          itemBuilder: (context, index) {
            final project = projectController.projects[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(project.title),
                subtitle: Text(project.description),
              ),
            );
          },
        );
      }),
    );
  }
}