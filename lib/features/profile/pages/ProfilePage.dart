import 'dart:io';
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
      appBar: AppBar(
        centerTitle: true ,
        title: const Text('Profile Page'),
      ),
      body: Obx(() {
        if (controller.userData.value == null ||
            controller.username.value.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              Center(
                child: Obx(() {
                  final pic = controller.userData.value?.profilePic;
                  // show the raw URL for debugging (remove in production)
                  final debugUrl = pic ?? 'no_url';

                  final urlWithTs = pic == null
                      ? null
                      : "$pic?t=${DateTime.now().millisecondsSinceEpoch}";

                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipOval(
                            child: Container(
                              width: 120,
                              height: 120,
                              color: Colors.grey[200],
                              child: urlWithTs == null
                                  ? Image.asset(AssetsManager.pp, fit: BoxFit.cover)
                                  : Image.network(
                                urlWithTs,
                                key: ValueKey(urlWithTs),
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                                errorBuilder: (ctx, err, st) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.person, size: 56),
                                  );
                                },
                                loadingBuilder: (ctx, child, progress) {
                                  if (progress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(value: progress.expectedTotalBytes != null
                                        ? progress.cumulativeBytesLoaded / (progress.expectedTotalBytes ?? 1)
                                        : null),
                                  );
                                },
                              ),
                            ),
                          ),

                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => SafeArea(
                                  child: Wrap(
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.photo_library),
                                        title: const Text('Gallery'),
                                        onTap: () async {
                                          final pickedImage = await controller.picker
                                              .pickImage(source: ImageSource.gallery);

                                          if (pickedImage != null) {
                                            controller.setImage(pickedImage);
                                          }
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.camera_alt),
                                        title: const Text('Camera'),
                                        onTap: () async {
                                          final pickedImage = await controller.picker
                                              .pickImage(source: ImageSource.camera);

                                          if (pickedImage != null) {
                                            controller.setImage(pickedImage);
                                          }
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),


                    ],
                  );
                }),
              ),


              const SizedBox(height: 20),

              // Email
              const Text(
                'Email:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    border: Border.all(color: Colors.black45, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    controller.userData.value!.email,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Username
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Username:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  controller.isEditing.value
                      ? SizedBox(
                    width: 150,
                    child: TextField(
                      controller: controller.usernameController,
                      onSubmitted: (_) {
                        controller.updateUsername();
                        controller.isEditing.value = false;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                      ),
                    ),
                  )
                      : Row(
                    children: [
                      // Text(
                      //   controller.username.value,
                      //   style: const TextStyle(
                      //       fontSize: 16, fontWeight: FontWeight.bold),
                      // ),
                      IconButton(
                        onPressed: () {
                          controller.isEditing.value = true;
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                ],
              )),

              const SizedBox(height: 10),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    border: Border.all(color: Colors.black45, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    controller.username.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.logout();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: const BoxDecoration(color: Colors.red),
                      child: const Text(
                        'logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(

                          title: Row(
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.red,
                                size: 28,
                              ),
                              const Text("Confirm"),
                            ],
                          ),
                          content: const Text("Are you sure you want to delete your account?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // الفانكشن هنا يجاهل ي ابن ال

                              },
                              child: const Text("YES"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: const BoxDecoration(color: Colors.red),
                      child: const Text(
                        'Delete your account',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )


                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
