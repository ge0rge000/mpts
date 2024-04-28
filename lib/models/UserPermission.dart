// To parse this JSON data, do
//
//     final userPermission = userPermissionFromJson(jsonString);

import 'dart:convert';

List<UserPermission> userPermissionFromJson(String str) => List<UserPermission>.from(json.decode(str).map((x) => UserPermission.fromJson(x)));

String userPermissionToJson(List<UserPermission> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserPermission {
  int id;
  String name;
  String email;
  String role;
  Map<String, bool> accessType;

  UserPermission({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.accessType,
  });

  factory UserPermission.fromJson(Map<String, dynamic> json) => UserPermission(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    accessType: Map.from(json["accessType"]).map((k, v) => MapEntry<String, bool>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "role": role,
    "accessType": Map.from(accessType).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
