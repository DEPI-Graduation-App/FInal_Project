import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/core/layouts/layout_controller.dart';

class BottomNavBar extends GetView<LayoutController> {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Colors.blueAccent;

    final isKeyboardOpen = MediaQuery
        .of(context)
        .viewInsets
        .bottom > 0;

    if (isKeyboardOpen) return const SizedBox.shrink();

    return Obx(() {
      return Container(
        color: Colors.transparent
        , child: Padding(

        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14,),

        child: SafeArea(
          child: Container(
            height: 74,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFD62828), width: 2.4),
              //           color: Color(0xFF0A1A2F),

              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.transparent,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  currentIndex: controller.currentIndex.value,
                  onTap: controller.changeTab,
                  type: BottomNavigationBarType.fixed,

                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  iconSize: 0,
                  items: [

                    controller.navItem(
                        0, Icons.home_outlined, Icons.home_rounded,
                        primaryColor),
                    controller.navItem(
                        1, Icons.auto_awesome_outlined, Icons.auto_awesome,
                        primaryColor),
                    controller.navItem(
                        2, Icons.bookmark_border, Icons.bookmark, primaryColor),
                    controller.navItem(
                        3, Icons.person_outline_rounded, Icons.person_rounded,
                        primaryColor),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      );
    });
  }
}
