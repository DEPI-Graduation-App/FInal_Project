import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/Screens/HomeScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
final cloud = Supabase.instance.client;

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Supabase.initialize(url: "https://tllqtcwjoakkmxpjhudx.supabase.co", anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRsbHF0Y3dqb2Fra214cGpodWR4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIxMDEyODQsImV4cCI6MjA3NzY3NzI4NH0.WMQ8x0EZZo4LArBNWHrT4L7a7vpv9ROUpmeeCzmd6mA");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Homescreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}