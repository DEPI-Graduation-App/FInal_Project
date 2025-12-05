import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/UserModel.dart';

final cloud = Supabase.instance.client;

class AuthService extends GetxService {
  final Rxn<UserModel> userData = Rxn<UserModel>();

  Future<UserModel?> register(
      String email,
      String password,
      String username,
      ) async {
    try {
      final response = await cloud.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        throw Exception("SignUp returned null user — check email confirmation settings");
      }

      await cloud.from('user').insert({
        'id': user.id,
        'username': username,
        'email': email,
      });

      final data = await cloud
          .from('user')
          .select()
          .eq('id', user.id)
          .single();

      return UserModel.fromJson(data);

    } catch (e, st) {
      print("REGISTER ERROR: $e");
      print("STACK: $st");
      rethrow;
    }
  }
  Future<UserModel?> login(String email, String password) async {
    try {
      final res = await cloud.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res.user == null) return null;

      final data = await cloud
          .from('user')
          .select()
          .eq('id', res.user!.id)
          .single();
      print(UserModel.fromJson(data).username);

      return UserModel.fromJson(data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserModel?> loadUser() async {
    final currentUser = cloud.auth.currentUser;

    if (currentUser == null) {
      print("No current user");
      return null;
    }

    final response = await cloud
        .from('user')
        .select()
        .eq('id', currentUser.id)
        .single();

    final user = UserModel.fromJson(response);
    userData.value = user;
    return user;
  }

  Future<bool> logout() async {
    try {
      await cloud.auth.signOut();
      return true;
    } catch (_) {
      return false;
    }
  }

  bool isLoggedIn() {
    return cloud.auth.currentUser != null;
  }

}
