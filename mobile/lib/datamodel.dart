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

  String? id;
  String? name;
  String? email;
  String? role;
  String? phoneNumber;   //when a phone number is obtained from the server

  //here is where all the information received from the server is stored

  returenData({this.email, this.name, this.role, this.phoneNumber, this.errors, this.id});
}

class Location {
  String? type;
  List<dynamic>? coordinates;
  Location({this.type, this.coordinates});
}

class returenCases {
  // Map<String, String>? location;

  String? id;
  String? status;
  String? subjectId;
  String? createdAt;
  String? handlerId;
  Location? location;

  //String? phoneNumber;   //when a phone number is obtained from the server
  //here is where all the information recieved from the server is stored
  returenCases(
      {this.id,
      this.status,
      this.subjectId,
      this.createdAt,
      this.handlerId,
      this.location});
}

class returenCars {
  // Map<String, String>? location;

  String? id;
  String? name;
  String? plateNumber;
  String? ownerId;
  String? region;

  //String? phoneNumber;   //when a phone number is obtained from the server
  //here is where all the information recieved from the server is stored
  returenCars({
    this.id,
    this.name,
    this.plateNumber,
    this.ownerId,
    this.region,
  });
}
