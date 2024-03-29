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
  int? caseNumber;
  bool? isActive;

  //here is where all the information received from the server is stored

  returenData({
    this.email,
    this.name,
    this.role,
    this.phoneNumber,
    this.errors,
    this.id,
    this.caseNumber,
    this.isActive
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'email': email,
      'role' : role,
      'phoneNumber' : phoneNumber
    };
  }
  factory returenData.fromJson(Map<String, dynamic> json){
    return returenData(id: json['id'],
        name: json['name'],
        email: json['email'],
        role: json['role'],
        phoneNumber: json['phoneNumber']
    );
  }

}

class Location {
  String? type;
  List<dynamic>? coordinates;
  Location({this.type, this.coordinates});
}
class CarSpec {
  String? name;
  String? model;
  String? color;
  String? plateNumber;
  CarSpec({this.name, this.model, this.color, this.plateNumber});
}
class DriverInfo {
  String? name;
  String? phoneNumber;
  DriverInfo({this.name, this.phoneNumber});
}

class returenCases {
  // Map<String, String>? location;

  String? id;
  String? status;
  String? subjectId;
  String? createdAt;
  String? handlerId;
  String? severity;
  CarSpec? car;
  String? verdict;
  DriverInfo? driver;
  Location? location;
  List<dynamic>? images;

  //String? phoneNumber;   //when a phone number is obtained from the server
  //here is where all the information received from the server is stored
  returenCases(
      {
        this.id,
        this.status,
        this.subjectId,
        this.car,
        this.verdict,
        this.driver,
        this.severity,
        this.createdAt,
        this.handlerId,
        this.location,
        this.images});
}

class returenCars {
  // Map<String, String>? location;

  String? id;
  String? name;
  String? plateNumber;
  String? model;
  String? color;
  String? ownerId;
  String? region;

  //String? phoneNumber;   //when a phone number is obtained from the server
  //here is where all the information recieved from the server is stored
  returenCars({
    this.id,
    this.name,
    this.plateNumber,
    this.model,
    this.color,
    this.ownerId,
    this.region,
  });
}
