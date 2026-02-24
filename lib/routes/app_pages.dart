import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';
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


    ];
}