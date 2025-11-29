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
Future<bool> updateUserProfilePic(String userId, String url) async {
  try {
    final response = await cloud
        .from('user')
        .update({'profile_picture': url})
        .eq('id', userId)
        .select();
    if (response != null && (response as List).isNotEmpty) {
      return true;
    } else {
      print("No rows updated. Check userId and table/column names.");
      return false;
    }
  } catch (e) {
    print("updateUserProfilePic error: $e");
    return false;
  }
}

}
