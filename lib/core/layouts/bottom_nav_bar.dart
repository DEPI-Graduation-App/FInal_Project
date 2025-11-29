import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/core/layouts/layout_controller.dart';

class BottomNavBar extends GetView<LayoutController> {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Colors.blueAccent;

    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                currentIndex: controller.currentIndex.value,
                onTap: controller.changeTab,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: primaryColor,
                unselectedItemColor: Colors.grey,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  _navItem(
                    0,
                    Icons.home_outlined,
                    Icons.home_rounded,
                    'Home',
                    primaryColor,
                  ),
                  _navItem(
                    1,
                    Icons.auto_awesome_outlined,
                    Icons.auto_awesome,
                    'AI Briefing',
                    Colors.purple,
                  ),
                  _navItem(
                    2,
                    Icons.person_outline_rounded,
                    Icons.person_rounded,
                    'Profile',
                    primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  BottomNavigationBarItem _navItem(
    int index,
    IconData icon,
    IconData activeIcon,
    String label,
    Color activeColor,
  ) {
    final isActive = controller.currentIndex.value == index;

    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: EdgeInsets.all(isActive ? 6 : 0),
        decoration: BoxDecoration(
          color: isActive ? activeColor.withOpacity(0.15) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isActive ? activeIcon : icon,
          size: isActive ? 24 : 20,
          color: isActive ? activeColor : Colors.grey[600],
        ),
      ),
      label: label,
    );
  }
}
