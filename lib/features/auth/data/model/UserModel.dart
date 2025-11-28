import 'dart:convert';

List<UserModel> userFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  final String id;
  final DateTime? createdAt;
  final String username;
  final String email;
  final String? profilePic;

  UserModel({
    required this.id,
    this.createdAt,
    required this.username,
    required this.email,
    this.profilePic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      username: json["username"] ?? "",
      email: json["email"] ?? "",
      profilePic: json["profile_picture"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "created_at": createdAt?.toIso8601String(),
      "username": username,
      "email": email,
      "profile_picture": profilePic,
    };
  }
}
