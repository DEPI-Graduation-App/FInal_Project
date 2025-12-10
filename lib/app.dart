import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_depi_final_project/core/routes/app_pages.dart';
import 'package:news_depi_final_project/features/auth/data/services/AuthService.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/generated/l10n.dart';
import 'core/controller/LanguageController.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red,
            brightness: Brightness.light,
        ),
      ),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue,
          brightness: Brightness.dark
        )
      ),
      //
      builder: (context, child) =>
          Overlay(initialEntries: [OverlayEntry(builder: (context) => child!)]),

      // localization
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,

      locale: Get.find<LanguageController>().initialLocale,

      // route
      initialRoute: AuthService().isLoggedIn()
          ? AppPages.layout
          : AppPages.loginPage,

      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
