class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String buyerId;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.buyerId,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      buyerId: json["buyer_id"],
    );
  }
}
