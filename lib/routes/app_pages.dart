import 'package:get/get.dart';

import '../core/middleware/auth_middleware.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/dashboard/binding/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/project/binding/project_binding.dart';
import '../modules/project/views/create_project_view.dart';
import '../modules/task/binding/task_binding.dart';
import '../modules/task/views/task_list_view.dart';
import '../modules/task/views/create_task_view.dart';
import '../modules/task/views/task_detail_view.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardView(),
      bindings: [DashboardBinding(), ProjectBinding()],
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.createproject,
      page: () => CreateProjectView(),
      binding: ProjectBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.taskList,
      page: () => const TaskListView(),
      binding: TaskBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.createTask,
      page: () => const CreateTaskView(),
      binding: TaskBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.taskDetail,
      page: () => const TaskDetailView(),
      binding: TaskBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
