import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_depi_final_project/core/constants/assets_manager.dart';
import 'package:news_depi_final_project/core/contoller/LanguageController.dart';
import 'package:news_depi_final_project/features/profile/controller/ProfileController.dart';
import 'package:news_depi_final_project/generated/l10n.dart';

class ProfilePage extends GetView<Profilecontroller> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          S.of(context).profileTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),

      body: Obx(() {
        if (controller.userData.value == null ||
            controller.username.value.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final rawPic = controller.userData.value?.profilePic;
        final pic = (rawPic == null || rawPic.isEmpty) ? null : rawPic;
        final urlWithTs = pic == null
            ? null
            : "$pic?t=${DateTime.now().millisecondsSinceEpoch}";

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: controller.accent, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: urlWithTs == null
                            ? Image.asset(AssetsManager.pp, fit: BoxFit.cover)
                            : Image.network(urlWithTs, fit: BoxFit.cover),
                      ),
                    ),

                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: controller.accent,
                          size: 20,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25),
                              ),
                            ),
                            context: context,
                            builder: (_) => SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    const SizedBox(height: 20),

                                    Text(
                                      S.of(context).chooseProfilePicture,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 15),

                                    ListTile(
                                      leading: const Icon(Icons.photo_library),
                                      title: Text(
                                        S.of(context).uploadFromGallery,
                                      ),
                                      onTap: () async {
                                        final picked = await controller.picker
                                            .pickImage(
                                              source: ImageSource.gallery,
                                            );
                                        if (picked != null)
                                          controller.setImage(picked);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.camera_alt),
                                      title: Text(S.of(context).takeAPhoto),
                                      onTap: () async {
                                        final picked = await controller.picker
                                            .pickImage(
                                              source: ImageSource.camera,
                                            );
                                        if (picked != null)
                                          controller.setImage(picked);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(color: Colors.blueAccent, blurRadius: 12),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).emailLabel,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        controller.userData.value!.email,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      S
                          .of(context)
                          .usernameLabel(controller.userData.value!.username),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      onChanged: (value) {
                        controller.isVisable.value = value.isNotEmpty;
                      },
                      controller: controller.usernameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[900],
                        hintText: S.of(context).editUsernameHint,
                        hintStyle: const TextStyle(color: Colors.white),
                        labelStyle: const TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Divider(),
              const SizedBox(height: 15),

              // Language Switcher
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(color: Colors.blueAccent, blurRadius: 12),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).language,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Get.find<LanguageController>().isArabic
                              ? 'العربية'
                              : 'English',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final langCtrl = Get.find<LanguageController>();
                            if (langCtrl.isArabic) {
                              langCtrl.changeLanguage('en');
                            } else {
                              langCtrl.changeLanguage('ar');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.accent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            S.of(context).changeLanguage,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),
              const Divider(),
              const SizedBox(height: 15),

              controller.isVisable.value
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.updateUsername,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.accent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          S.of(context).updateSaveButton,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    S.of(context).logoutButton,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        );
      }),
    );
  }
}
