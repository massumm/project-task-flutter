import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_task_flutter/routes/app_routes.dart';
import '../../admin/views/admin_dashboard_view.dart';
import '../../project/controller/project_controller.dart';
import '../controller/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(_getTitle(controller.role.value))),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
          ),
        ],
      ),
      body: Obx(() {
        final role = controller.role.value;
        switch (role) {
          case "admin":
            return const AdminDashboardView();
          case "buyer":
            return _BuyerDashboard();
          case "developer":
            return _DeveloperDashboard();
          default:
            return const Center(child: Text("Unknown role"));
        }
      }),
      floatingActionButton: Obx(() {
        if (controller.role.value == "buyer") {
          return FloatingActionButton.extended(
            onPressed: () => Get.toNamed("/create-project"),
            icon: const Icon(Icons.add),
            label: const Text("New Project"),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  String _getTitle(String role) {
    switch (role) {
      case "admin":
        return "Admin Dashboard";
      case "buyer":
        return "My Projects";
      case "developer":
        return "My Tasks";
      default:
        return "Dashboard";
    }
  }
}

class _BuyerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final projectController = Get.find<ProjectController>();

    return Obx(() {
      if (projectController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (projectController.projects.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.folder_open_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                "No projects yet",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Tap + to create your first project",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: projectController.fetchProjects,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: projectController.projects.length,
          itemBuilder: (context, index) {
            final project = projectController.projects[index];
            print("project in project"+project.id);
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () => Get.toNamed(
                  AppRoutes.taskList,
                  arguments: {
                    "projectId": project.id,
                    "projectTitle": project.title,
                  },
                ),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.folder_outlined,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.title,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              project.description,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

class _DeveloperDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Developer sees "assigned tasks" via their projects
    final projectController = Get.find<ProjectController>();

    return Obx(() {
      if (projectController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (projectController.projects.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.task_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                "No assigned projects",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Projects with tasks assigned to you will appear here",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: projectController.fetchProjects,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: projectController.projects.length,
          itemBuilder: (context, index) {
            final project = projectController.projects[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () => Get.toNamed(
                  "/task-list",
                  arguments: {
                    "projectId": project.id,
                    "projectTitle": project.title,
                  },
                ),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.code,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSecondaryContainer,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.title,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              project.description,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
