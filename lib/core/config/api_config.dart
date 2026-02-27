class ApiConfig {
  static const String baseUrl =
      "https://project-task-backend-fmq6.onrender.com";

  // Auth
  static const String login = "$baseUrl/auth/login";
  static const String register = "$baseUrl/auth/register";
  static const String me = "/auth/me";
  static const String userlist = "/auth/userlist";

  // Projects
  static const String projects = "$baseUrl/projects/";
  static const String myProjects = "/projects/mine";

  // Tasks
  static const String tasks = "$baseUrl/tasks/";
  static String projectTasks(String projectId) => "/tasks/project/$projectId";
  static String taskDetail(String taskId) => "/tasks/$taskId";
  static String startTask(String taskId) => "/tasks/$taskId/start";
  static String submitTask(String taskId) => "/tasks/$taskId/submit";

  // Payments
  static String payForTask(String taskId) => "/payments/$taskId";

  // Admin
  static const String adminStats = "$baseUrl/admin/stats";
}
