import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controller/task_controller.dart';
import '../model/task_model.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    final projectId = Get.arguments?["projectId"] ?? "";
    final projectTitle = Get.arguments?["projectTitle"] ?? "Tasks";
    final role = GetStorage().read("role") ?? "";

    controller.fetchProjectTasks(projectId);

    return Scaffold(
      appBar: AppBar(title: Text(projectTitle), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.tasks.isEmpty) {
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
                  "No tasks yet",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.tasks.length,
          itemBuilder: (context, index) {
            final task = controller.tasks[index];
            return _TaskCard(task: task, projectId: projectId);
          },
        );
      }),
      floatingActionButton: role == "buyer"
          ? FloatingActionButton.extended(
              onPressed: () => Get.toNamed(
                "/create-task",
                arguments: {"projectId": projectId},
              ),
              icon: const Icon(Icons.add),
              label: const Text("New Task"),
            )
          : null,
    );
  }
}

class _TaskCard extends StatelessWidget {
  final TaskModel task;
  final String projectId;

  const _TaskCard({required this.task, required this.projectId});

  Color _statusColor(BuildContext context) {
    switch (task.status) {
      case "todo":
        return Colors.grey;
      case "in_progress":
        return Colors.blue;
      case "submitted":
        return Colors.orange;
      case "paid":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _statusIcon() {
    switch (task.status) {
      case "todo":
        return Icons.radio_button_unchecked;
      case "in_progress":
        return Icons.pending;
      case "submitted":
        return Icons.upload_file;
      case "paid":
        return Icons.check_circle;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => Get.toNamed(
          "/task-detail",
          arguments: {"taskId": task.id, "projectId": projectId},
        ),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor(context).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _statusIcon(),
                          size: 14,
                          color: _statusColor(context),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          task.status.replaceAll("_", " ").toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: _statusColor(context),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                task.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text(
                    "\$${task.hourlyRate}/hr",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (task.hoursSpent != null) ...[
                    const SizedBox(width: 16),
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Text(
                      " ${task.hoursSpent}h",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                  if (task.isSubmitted || task.isPaid) ...[
                    const SizedBox(width: 16),
                    Text(
                      "Total: \$${task.totalAmount.toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
