import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/Controllers/HomeController.dart';
import 'package:news_depi_final_project/Controllers/LoginController.dart';
import 'package:news_depi_final_project/Controllers/RegisterController.dart';
import 'package:news_depi_final_project/Screens/AuthScreens/LoginScreen.dart';
import 'package:news_depi_final_project/Screens/AuthScreens/RegisterScreen.dart';
import 'package:news_depi_final_project/Screens/HomeScreen.dart';
import 'package:news_depi_final_project/Roads/road.dart';
import 'package:news_depi_final_project/Services/AuthService.dart';
import 'package:news_depi_final_project/Services/NewsService.dart';
import 'package:news_depi_final_project/Supabase_Keys/database_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: DatabaseKeys.supabaseUrl, anonKey: DatabaseKeys.supabaseAnonKey);
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AuthService().isLoggedIn() ? Road.home : Road.login,
      initialBinding: BindingsBuilder((){
        Get.lazyPut(()=>NewsService());
      }),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            name: Road.home,
            page: () => const HomeScreen(),
            binding: BindingsBuilder((){
              Get.put(HomeController());
            }),
        ),
        GetPage(
            name: Road.login,
            page: () => const LoginScreen(),
            binding: BindingsBuilder((){
              Get.put(LoginController());
            })
        ),
        GetPage(
            name: Road.register,
            page: () => const RegisterScreen(),
            binding: BindingsBuilder((){
              Get.put(RegisterController());
            })
        ),
      ],
    );
  }
}

