import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:news_depi_final_project/core/routes/app_pages.dart';
import 'package:news_depi_final_project/features/auth/data/services/AuthService.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) =>
          Overlay(initialEntries: [OverlayEntry(builder: (context) => child!)]),

      initialRoute: AuthService().isLoggedIn()
          ? AppPages.layout
          : AppPages.loginPage,

      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
