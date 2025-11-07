import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:news_depi_final_project/main.dart';
import '../Models/UserModel.dart';
final cloud = Supabase.instance.client;

class AuthService extends GetxService {
  final Rxn<UserModel> userData = Rxn<UserModel>();

  Future<UserModel?> register(
      String email,
      String password,
      String username,
      ) async {
    try {
      final response = await cloud.auth.signUp(email: email, password: password);
      final user = response.user;

      if (user != null) {
        await cloud.from('users').insert({
          'id': user.id,
          'username': username,
          'email': email,
        });

        final userData =
        await cloud.from('users').select().eq('id', user.id).single();

        return UserModel.fromJson(userData);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  Future<UserModel?> login(String email, String password) async {
    try {
      final res = await cloud.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res.user == null) return null;

      final userData =
      await cloud.from('users').select().eq('id', res.user!.id).single();

      return UserModel.fromJson(userData);
    } catch (e) {
      print(e);
      return null;
    }
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
    final user = cloud.auth.currentUser;
    return user != null;
  }
}