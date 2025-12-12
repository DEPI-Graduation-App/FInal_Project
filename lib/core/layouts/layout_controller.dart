import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController {
  final currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;

  }

  BottomNavigationBarItem navItem(
      int index,
      IconData icon,
      IconData activeIcon,
      Color activeColor,
      ) {
    final isActive = currentIndex.value == index;

    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isActive ? activeColor.withOpacity(0.15) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isActive ? activeIcon : icon,
          size: 24,
          color:Color(0xFFD62828)
        ),
      ),
      label: '',
    );
  }
}


