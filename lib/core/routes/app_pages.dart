import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:news_depi_final_project/core/bindings/home_binding.dart';
import 'package:news_depi_final_project/core/bindings/layout_binding.dart';
import 'package:news_depi_final_project/core/layouts/main_layout.dart';
import 'package:news_depi_final_project/features/article_detail/controller/article_detail_controller.dart';
import 'package:news_depi_final_project/features/article_detail/pages/article_detail_page.dart';
import 'package:news_depi_final_project/features/auth/presentation/controller/LoginController.dart';
import 'package:news_depi_final_project/features/profile/controller/ProfileController.dart';
import 'package:news_depi_final_project/features/auth/presentation/controller/RegisterController.dart';
import 'package:news_depi_final_project/features/auth/presentation/pages/LoginScreen.dart';
import 'package:news_depi_final_project/features/auth/presentation/pages/RegisterScreen.dart';
import 'package:news_depi_final_project/features/home/presentation/pages/HomeScreen.dart';
import 'package:news_depi_final_project/features/profile/pages/ProfilePage.dart';
import 'package:news_depi_final_project/features/briefing/pages/briefing_page.dart';

class AppPages {
  static const String homePage = '/home';
  static const String loginPage = '/login';
  static const String registerPage = '/register';
  static const String profilePage = '/profile';
  static const String settingsPage = '/settings';
  static const String categoriesPage = '/categories';
  static const String articleDetailsPage = '/articleDetails';
  static const String News = '/newsList';
  static const String layout = '/layout';

  static final List<GetPage> routes = [
    GetPage(
      name: homePage,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: loginPage,
      page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        Get.put(LoginController());
      }),
    ),
    GetPage(
      name: registerPage,
      page: () => const RegisterScreen(),
      binding: BindingsBuilder(() {
        Get.put(RegisterController());
      }),
    ),
    //
    GetPage(name: layout, page: () => MainLayout(), binding: LayoutBinding()),
    //
    GetPage(
      name: profilePage,
      page: () => ProfilePage(),
      binding: BindingsBuilder(() {
        Get.put(Profilecontroller());
      }),
    ),
    GetPage(
      name: articleDetailsPage,
      page: () => ArticleDetailsPage(),
      binding: BindingsBuilder(() {
        Get.put(ArticleDetailController());
      }),
    ),
    GetPage(name: '/news_list', page: () => const HomeScreen()),
    GetPage(name: '/ai_briefing', page: () => const AiBriefingPage()),
  ];
}
