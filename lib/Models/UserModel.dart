import 'dart:convert';

List<UserModel> userFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  String id;
  DateTime createdAt;
  String username;
  String email;
  String? profilepic;

  UserModel({
    required this.id,
    required this.createdAt,
    required this.username,
    required this.email,
    this.profilepic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    username: json["username"],
    email: json["email"],
    profilepic: json["profilepic"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "username": username,
    "email": email,
    "profilepic":profilepic,
  };
}
