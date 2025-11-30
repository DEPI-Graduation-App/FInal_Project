// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:news_depi_final_project/core/routes/app_pages.dart';
//
// class AppDrawer extends StatelessWidget {
//   final RxBool isDark = false.obs;
//
//   AppDrawer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           const DrawerHeader(
//             child: Center(
//               child: Text(
//                 "Settings",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//
//           Obx(() => SwitchListTile(
//             title: const Text("Dark Mode"),
//             secondary: const Icon(Icons.dark_mode),
//             value: isDark.value,
//             onChanged: (value) {
//               isDark.toggle();
//               Get.changeThemeMode(
//                   value ? ThemeMode.dark : ThemeMode.light);
//               print(Get.isDarkMode);
//             },
//           )),
//
//           ListTile(
//             leading: const Icon(Icons.favorite),
//             title: const Text("Favorites"),
//             onTap: () {
//               Navigator.pop(context);
//              // Get.toNamed(AppPages());
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
