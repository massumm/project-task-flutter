import 'package:get/get.dart';

import '../core/middleware/auth_middleware.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/dashboard/binding/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/project/binding/project_binding.dart';
import '../modules/project/views/create_project_view.dart';
import 'app_routes.dart';

class AppPages{
  static final routes=[
    // GetPage(
    //   name: AppRoutes.splash,
    //   page: ()=>const SplashScreen(),
    // ),

    GetPage(
      name: AppRoutes.login,
      page: ()=>const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: ()=>const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.createproject,
      page: ()=> CreateProjectView(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name:  AppRoutes.dashboard,
      page: () => DashboardView(),
      bindings: [DashboardBinding(),
        ProjectBinding()
      ],
      middlewares: [AuthMiddleware()],
    ),


    ];
}