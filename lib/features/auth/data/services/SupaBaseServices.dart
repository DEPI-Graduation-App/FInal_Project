import 'dart:io';


import 'AuthService.dart';

class SupaBaseServices {

Future<String?> uploadProfilePic(File file, String userId) async {
  final fileName = "$userId-${DateTime.now().millisecondsSinceEpoch}.jpg";

  final res = await cloud.storage
      .from('profilePics')
      .upload(fileName, file);

  if (res == null) return null;

  final publicUrl =
  cloud.storage.from('profilePics').getPublicUrl(fileName);

  return publicUrl;
}

// Future<bool> updateUserProfilePic(String userId, String url) async {
//   try {
//     final response = await cloud
//         .from('users')
//         .update({'profile_picture': url})
//         .eq('id', userId);
//
//     if (response != null) {
//       return true;
//     } else {
//       return false;
//     }
//   } catch (e) {
//     print("updateUserProfilePic error: $e");
//     return false;
//   }
// }

}
