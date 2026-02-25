class ProjectModel {
  final int id;
  final String title;
  final String description;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
    );
  }
}