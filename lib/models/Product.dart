// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  int id;
  String name;
  String productCase;
  String? permission; // Optional field to store permission

  Product({
    required this.id,
    required this.name,
    required this.productCase,
    this.permission
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    productCase: json["case"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "case": productCase,
  };
  void setPermission(String perm) {
    this.permission = perm;
  }
}
