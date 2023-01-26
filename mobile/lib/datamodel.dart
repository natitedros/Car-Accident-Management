// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel? dataModelFromJson(String str) =>
    DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel? data) => json.encode(data!.toJson());

class DataModel {
  DataModel({
    this.name,
    this.role,
    this.email,
    this.password,
    this.id,
    this.createdAt,
  });

  String? name;
  String? role;
  String? email;
  String? password;
  String? id;
  DateTime? createdAt;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        name: json["name"],
        role: json["role"],
        email: json["email"],
        password: json["password"],
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "role": role,
        "email": email,
        "password": password,
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
      };
}

class returenData {
  Map<String, String>? errors;
  String? name;
  String? email;
  String? role;

  returenData({this.email, this.name, this.role, this.errors});
}
