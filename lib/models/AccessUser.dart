// To parse this JSON data, do
//
//     final accessUser = accessUserFromJson(jsonString);

import 'dart:convert';
AccessUser accessUserFromJson(String str) =>
    AccessUser.fromJson(json.decode(str));

String accessUserToJson(AccessUser data) => json.encode(data.toJson());


class AccessUser {
  bool first;
  bool secound;
  bool third;

  AccessUser({
    required this.first,
    required this.secound,
    required this.third,
  });

  factory AccessUser.fromJson(Map<String, dynamic> json) => AccessUser(
    first: json["first"] == '1', // Convert string to bool
    secound: json["secound"] == '1', // Convert string to bool
    third: json["third"] == '1', // Convert string to bool
  );

  Map<String, dynamic> toJson() => {
    "first": first ? '1' : '0', // Convert bool to string
    "second": secound ? '1' : '0', // Convert bool to string
    "third": third ? '1' : '0', // Convert bool to string
  };
}


