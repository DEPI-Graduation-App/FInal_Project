import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_depi_final_project/core/constants/assets_manager.dart';
import 'package:news_depi_final_project/features/profile/controller/ProfileController.dart';

class ProfilePage extends GetView<Profilecontroller> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Profile')),
      body: Obx(() {
        if (controller.userData.value == null ||
            controller.username.value.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final rawPic = controller.userData.value?.profilePic;
        final pic = (rawPic == null || rawPic.isEmpty) ? null : rawPic;
        final urlWithTs =
        pic == null ? null : "$pic?t=${DateTime.now().millisecondsSinceEpoch}";

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              /// ----------------------------------------------------------
              ///                PROFILE PICTURE + CAMERA ICON
              /// ----------------------------------------------------------
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 130,
                        height: 130,
                        color: Colors.grey[200],
                        child: urlWithTs == null
                            ? Image.asset(AssetsManager.pp, fit: BoxFit.cover)
                            : Image.network(
                          urlWithTs,
                          fit: BoxFit.cover,
                          width: 130,
                          height: 130,
                        ),
                      ),
                    ),

                    /// Edit picture button
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, size: 18),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const Text("Gallery"),
                                    onTap: () async {
                                      final picked = await controller.picker.pickImage(
                                          source: ImageSource.gallery);
                                      if (picked != null) controller.setImage(picked);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.camera_alt),
                                    title: const Text("Camera"),
                                    onTap: () async {
                                      final picked = await controller.picker.pickImage(
                                          source: ImageSource.camera);
                                      if (picked != null) controller.setImage(picked);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 35),

              /// ----------------------------------------------------------
              ///                         EMAIL (read only)
              /// ----------------------------------------------------------
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  controller.userData.value!.email,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),

              const SizedBox(height: 25),

              /// ----------------------------------------------------------
              ///                         USERNAME (editable)
              /// ----------------------------------------------------------
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Username",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: controller.usernameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Edit username ${controller.userData.value!.username}",
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// ----------------------------------------------------------
              ///                UPDATE BUTTON (username only)
              /// ----------------------------------------------------------
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.updateUsername,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Update / Save",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// ----------------------------------------------------------
              ///                LOGOUT + DELETE ACCOUNT BUTTONS
              /// ----------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.logout,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text("Log out",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Row(
                              children: const [
                                Icon(Icons.warning, color: Colors.red),
                                SizedBox(width: 6),
                                Text("Confirm"),
                              ],
                            ),
                            content: const Text(
                              "Are you sure you want to delete your account?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("YES"),
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text("Delete account",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
