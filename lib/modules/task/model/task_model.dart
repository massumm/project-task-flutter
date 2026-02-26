class TaskModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final double hourlyRate;
  final double? hoursSpent;
  final String? solutionFile;
  final String projectId;
  final String assignedDeveloper;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.hourlyRate,
    this.hoursSpent,
    this.solutionFile,
    required this.projectId,
    required this.assignedDeveloper,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      status: json["status"],
      hourlyRate: (json["hourly_rate"] as num).toDouble(),
      hoursSpent: json["hours_spent"] != null
          ? (json["hours_spent"] as num).toDouble()
          : null,
      solutionFile: json["solution_file"],
      projectId: json["project_id"],
      assignedDeveloper: json["assigned_developer"],
    );
  }

  double get totalAmount => hourlyRate * (hoursSpent ?? 0);

  bool get isSubmitted => status == "submitted";
  bool get isPaid => status == "paid";
  bool get isTodo => status == "todo";
  bool get isInProgress => status == "in_progress";
}
