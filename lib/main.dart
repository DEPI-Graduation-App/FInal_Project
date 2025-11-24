import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/Screens/AuthScreens/LoginScreen.dart';
import 'package:news_depi_final_project/Screens/HomeScreen.dart';
import 'package:news_depi_final_project/Services/AuthService.dart';
import 'package:news_depi_final_project/Supabase_Keys/database_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: DatabaseKeys.supabaseUrl, anonKey: DatabaseKeys.supabaseAnonKey);
    runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: AuthService().isLoggedIn() ? HomeScreen() : LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}