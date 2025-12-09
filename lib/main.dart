import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_depi_final_project/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'core/controller/LanguageController.dart';
import 'features/Notifications/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Local storage
  await GetStorage.init();

  // Load .env
  await dotenv.load(fileName: ".env");

  // Gemini
  Gemini.init(apiKey: dotenv.env['GEMINI_API']!);

  // Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_APIKEY']!,
  );

  // Initialize Awesome Notifications
  await NotificationService.initializeNotifications();

  // Ask permissions
  await NotificationService.requestPermissions();

  // Language Controller
  Get.put(LanguageController());

  runApp(const MyApp());
}
