import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_depi_final_project/core/routes/app_pages.dart';
import 'package:news_depi_final_project/features/auth/data/model/UserModel.dart';
import 'package:news_depi_final_project/generated/l10n.dart';

import '../../auth/data/services/AuthService.dart';
import '../../auth/data/services/SupaBaseServices.dart';

class Profilecontroller extends GetxController {
  RxString email = ''.obs;
  RxString username = ''.obs;
  RxBool loading = false.obs;
  Rx<XFile?> pickedImage = Rx<XFile?>(null);
  final usernameController = TextEditingController();
  final Color accent = Colors.blueAccent;
  RxBool isVisable = false.obs;
  final ImagePicker picker = ImagePicker();

  final Rxn<UserModel> userData = Rxn<UserModel>();
  RxBool isEditing = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> updateUsername() async {
    final newUsername = usernameController.text.trim();
    if (newUsername.isEmpty) {
      Get.snackbar(
        S.current.error,
        S.current.youDidntUpdateNothing,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    final uid = userData.value?.id;

    if (uid == null) {
      Get.snackbar(S.current.error, S.current.userNotLoggedIn);
      return;
    }

    try {
      await cloud.from("user").update({"username": newUsername}).eq("id", uid);

      username.value = newUsername;
      userData.value = userData.value!.copyWith(username: newUsername);

      Get.snackbar(S.current.success, S.current.usernameUpdated);
      usernameController.clear();
      isVisable.value = false;
    } catch (e) {
      Get.snackbar(S.current.error, e.toString());
    }
  }

  Future<void> fetchUserData() async {
    loading.value = true;

    final user = await AuthService().loadUser();
    if (user != null) {
      userData.value = user;
      username.value = user.username;
      email.value = user.email;
    }

    loading.value = false;
  }

  Future<void> logout() async {
    await AuthService().logout();
    Get.offAllNamed(AppPages.loginPage);
  }

  void setImage(XFile file) async {
    pickedImage.value = file;

    final userId = userData.value?.id;
    if (userId == null) return;

    await pickAndUploadImage(userId);
  }

  Future<void> pickAndUploadImage(String userId) async {
    if (pickedImage.value == null) return;

    File file = File(pickedImage.value!.path);

    // Step A: Validate image size BEFORE uploading
    final valid = await validateImageSize(file);
    if (!valid) return;

    // Step 1: Upload to Supabase
    final baseUrl = await SupaBaseServices().uploadProfilePic(file, userId);
    debugPrint('baseUrl -> $baseUrl');

    if (baseUrl == null) return;

    // Step 2: Add ONE cache buster
    final cacheBustedUrl =
        "$baseUrl?t=${DateTime.now().millisecondsSinceEpoch}";

    // Step 3: Save to database
    final updated = await SupaBaseServices().updateUserProfilePic(
      userId,
      cacheBustedUrl,
    );

    debugPrint('updateUserProfilePic -> $updated');

    if (updated) {
      try {
        await NetworkImage(cacheBustedUrl).evict();
        PaintingBinding.instance.imageCache.clear();
      } catch (_) {}

      userData.value = userData.value!.copyWith(profilePic: cacheBustedUrl);
      userData.refresh();

      pickedImage.value = null;
    }
  }
  Future<File?> cropImageToMaxSize(File file, int maxWidth, int maxHeight) async {
    try {
      final bytes = await file.readAsBytes();
      final decoded = await decodeImageFromList(bytes);

      int width = decoded.width;
      int height = decoded.height;

      // If already within limits → no cropping needed
      if (width <= maxWidth && height <= maxHeight) {
        return file;
      }

      // Calculate cropping dimensions
      int cropWidth = width > maxWidth ? maxWidth : width;
      int cropHeight = height > maxHeight ? maxHeight : height;

      // Center crop offsets
      int x = (width - cropWidth) ~/ 2;
      int y = (height - cropHeight) ~/ 2;

      // Convert RawImage to ui.Image to process
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder);
      final paint = Paint();

      canvas.drawImageRect(
        decoded,
        Rect.fromLTWH(x.toDouble(), y.toDouble(), cropWidth.toDouble(),
            cropHeight.toDouble()),
        Rect.fromLTWH(0, 0, cropWidth.toDouble(), cropHeight.toDouble()),
        paint,
      );

      final picture = recorder.endRecording();
      final croppedImage =
      await picture.toImage(cropWidth, cropHeight);

      final pngBytes = await croppedImage.toByteData(format: ImageByteFormat.png);

      if (pngBytes == null) return null;

      final tempPath = file.path;
      final croppedFile = File(tempPath)
        ..writeAsBytesSync(pngBytes.buffer.asUint8List());

      return croppedFile;
    } catch (e) {
      debugPrint("Cropping failed: $e");
      return null;
    }
  }

  Future<bool> validateImageSize(
      File file, {
        int maxWidth = 2000,
        int maxHeight = 2000,
      }) async {
    try {
      final bytes = await file.readAsBytes();
      final decoded = await decodeImageFromList(bytes);

      debugPrint(
          "Selected image width: ${decoded.width}, height: ${decoded.height}");

      // If image is too big → crop it
      if (decoded.width > maxWidth || decoded.height > maxHeight) {
        Get.snackbar(
          S.current.processing,
          S.current.imageTooLargeCropping,
        );

        final cropped = await cropImageToMaxSize(file, maxWidth, maxHeight);

        if (cropped == null) {
          Get.snackbar(S.current.error, S.current.unableToCropImage);
          return false;
        }

        // Replace original with cropped file
        pickedImage.value = XFile(cropped.path);
        return true;
      }

      return true; // Image fits
    } catch (e) {
      debugPrint("Failed to read image size: $e");
      Get.snackbar(S.current.error, S.current.unableToReadImage);
      return false;
    }
  }

}
