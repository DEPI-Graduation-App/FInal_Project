import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_depi_final_project/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/core/contoller/LanguageController.dart';
import 'features/Notifications/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Local storage
  await GetStorage.init();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Gemini API
  Gemini.init(apiKey: dotenv.env['GEMINI_API']!);

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_APIKEY']!,
  );

  // Initialize Local Notifications
  await NotificationService.init();

  // Request notifications permission (Android only)
  await NotificationService.requestPermissions();

  // Initialize Language Controller
  Get.put(LanguageController());

  // Run the app
  runApp(const MyApp());
}
