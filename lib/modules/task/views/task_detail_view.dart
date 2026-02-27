import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/config/api_config.dart';
import '../../payment/repository/payment_repository.dart';
import '../controller/task_controller.dart';

class TaskDetailView extends StatelessWidget {
  const TaskDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    final taskId = Get.arguments?["taskId"] ?? "";
    final role = GetStorage().read("role") ?? "";

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchTask(taskId);
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Task Details"), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value &&
            controller.currentTask.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final task = controller.currentTask.value;
        if (task == null) {
          return const Center(child: Text("Task not found"));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Title & Status
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              task.title,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          _StatusChip(status: task.status),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        task.description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Financial Details
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Financial Details",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      _DetailRow(
                        icon: Icons.attach_money,
                        label: "Hourly Rate",
                        value: "\$${task.hourlyRate}/hr",
                      ),
                      if (task.hoursSpent != null) ...[
                        const SizedBox(height: 12),
                        _DetailRow(
                          icon: Icons.access_time,
                          label: "Hours Spent",
                          value: "${task.hoursSpent} hours",
                        ),
                        const SizedBox(height: 12),
                        _DetailRow(
                          icon: Icons.receipt_long,
                          label: "Total Amount",
                          value: "\$${task.totalAmount.toStringAsFixed(2)}",
                          isBold: true,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Developer Actions
              if (role == "developer") ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Developer Actions",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 16),
                        if (task.isTodo)
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () => controller.startTask(task.id),
                              icon: const Icon(Icons.play_arrow),
                              label: const Text("Start Task"),
                            ),
                          ),
                        if (task.isInProgress) ...[
                          TextField(
                            controller: controller.hoursSpentController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: "Hours Spent",
                              prefixIcon: Icon(Icons.access_time),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () => controller.submitTask(task.id),
                              icon: const Icon(Icons.upload_file),
                              label: const Text("Submit Solution (ZIP)"),
                            ),
                          ),
                        ],
                        if (task.isSubmitted)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.hourglass_bottom,
                                  color: Colors.orange,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    "Waiting for buyer to review and pay",
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (task.isPaid)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.green),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    "Payment received! Task completed.",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],

              // Buyer Actions
              if (role == "buyer") ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Buyer Actions",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 16),
                        if (task.isSubmitted) ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.orange,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Task Submitted",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Pay \$${task.totalAmount.toStringAsFixed(2)} to unlock the solution",
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "🔒 Solution file is locked until payment",
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () async {
                                      try {
                                        final paymentRepo =
                                            Get.find<PaymentRepository>();
                                        await paymentRepo.payForTask(task.id);
                                        Get.snackbar(
                                          "Success",
                                          "Payment completed!",
                                        );
                                        controller.fetchTask(task.id);
                                      } catch (e) {
                                        Get.snackbar(
                                          "Error",
                                          "Payment failed: $e",
                                        );
                                      }
                                    },
                              icon: const Icon(Icons.payment),
                              label: Text(
                                "Pay Now - \$${task.totalAmount.toStringAsFixed(2)}",
                              ),
                            ),
                          ),
                        ],
                        if (task.isPaid) ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.green),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    "Payment completed! You can download the solution.",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (task.solutionFile != null) ...[
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () async {
                                  final solutionPath =
                                      task.solutionFile!.startsWith('/')
                                      ? task.solutionFile!
                                      : '/${task.solutionFile!}';
                                  final url = Uri.parse(
                                    "${ApiConfig.baseUrl}$solutionPath",
                                  );
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(
                                      url,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  }
                                },
                                icon: const Icon(Icons.download),
                                label: const Text("Download Solution"),
                              ),
                            ),
                          ],
                        ],
                        if (task.isTodo || task.isInProgress)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  task.isTodo
                                      ? Icons.radio_button_unchecked
                                      : Icons.pending,
                                  color: task.isTodo
                                      ? Colors.grey
                                      : Colors.blue,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    task.isTodo
                                        ? "Waiting for developer to start"
                                        : "Developer is working on this task",
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      }),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  Color get color {
    switch (status) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        status.replaceAll("_", " ").toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isBold;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 12),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
