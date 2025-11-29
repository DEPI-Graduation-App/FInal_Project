import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/core/layouts/bottom_nav_bar.dart';
import 'package:news_depi_final_project/core/layouts/layout_controller.dart';
import 'package:news_depi_final_project/features/briefing/pages/briefing_page.dart';
import 'package:news_depi_final_project/features/home/presentation/pages/HomeScreen.dart';
import 'package:news_depi_final_project/features/profile/pages/ProfilePage.dart';

import '../../features/news/pages/SelectedNewsScreen.dart';

class MainLayout extends GetView<LayoutController> {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(LayoutController());

    final pages = const [HomeScreen(), AiBriefingPage(), ProfilePage(),];

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: pages,
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}
