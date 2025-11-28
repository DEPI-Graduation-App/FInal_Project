import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/core/layouts/layout_controller.dart';

class BottomNavBar extends GetView<LayoutController> {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Colors.blueAccent;

    return Obx(
      () => Container(
        height: 100,
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
                  index: 0,
                  controller: controller,
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  label: 'Home',
                  activeColor: primaryColor,
                ),
                _navItem(
                  index: 1,
                  controller: controller,
                  icon: Icons.auto_awesome_outlined,
                  activeIcon: Icons.auto_awesome,
                  label: 'AI Briefing',
                  activeColor: Colors.purple,
                ),
                _navItem(
                  index: 2,
                  controller: controller,
                  icon: Icons.person_outline_rounded,
                  activeIcon: Icons.person_rounded,
                  label: 'Profile',
                  activeColor: primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _navItem({
    required int index,
    required LayoutController controller,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required Color activeColor,
  }) {
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
