import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_task_flutter/routes/app_pages.dart';
import 'package:project_task_flutter/routes/app_routes.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: AppRoutes.login,
    getPages: AppPages.routes,
  )
  );
}