// To parse this JSON data, do
//
//     final feature = featureFromJson(jsonString);

import 'dart:convert';

List<Feature> featureFromJson(String str) => List<Feature>.from(json.decode(str).map((x) => Feature.fromJson(x)));

String featureToJson(List<Feature> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Feature {
  String name;
  String value;

  Feature({
    required this.name,
    required this.value,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
  };
}
