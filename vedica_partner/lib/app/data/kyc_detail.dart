// To parse this JSON data, do
//
//     final allKycModel = allKycModelFromJson(jsonString);

import 'dart:convert';

AllKycModel allKycModelFromJson(String str) =>
    AllKycModel.fromJson(json.decode(str));

String allKycModelToJson(AllKycModel data) => json.encode(data.toJson());

class AllKycModel {
  AllKycModel({
    this.status,
    this.subCode,
    this.message,
    this.error,
    this.items,
  });

  bool? status;
  int? subCode;
  String? message;
  String? error;
  Items? items;

  factory AllKycModel.fromJson(Map<String, dynamic> json) => AllKycModel(
        status: json["status"],
        subCode: json["subCode"],
        message: json["message"],
        error: json["error"],
        items: json["items"] == null ? null : Items.fromJson(json["items"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "subCode": subCode,
        "message": message,
        "error": error,
        "items": items?.toJson(),
      };
}

class Items {
  Items({
    this.userId,
    this.name,
    this.work,
    this.address,
    this.aadhaarNumber,
    this.aadhaarFront,
    this.aadhaarBack,
    this.panNumber,
    this.panFront,
    this.dateOfBirth,
    this.gender,
    this.isVerified,
    this.createdAt,
  });

  String? userId;
  String? name;
  String? work;
  String? address;
  String? aadhaarNumber;
  String? aadhaarFront;
  String? aadhaarBack;
  String? panNumber;
  String? panFront;
  String? dateOfBirth;
  String? gender;
  bool? isVerified;
  DateTime? createdAt;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        userId: json["userId"],
        name: json["name"],
        work: json["work"],
        address: json["address"],
        aadhaarNumber: json["aadhaarNumber"],
        aadhaarFront: json["aadhaarFront"],
        aadhaarBack: json["aadhaarBack"],
        panNumber: json["panNumber"],
        panFront: json["panFront"],
        dateOfBirth: json["DateOfBirth"],
        gender: json["gender"],
        isVerified: json["isVerified"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "work": work,
        "address": address,
        "aadhaarNumber": aadhaarNumber,
        "aadhaarFront": aadhaarFront,
        "aadhaarBack": aadhaarBack,
        "panNumber": panNumber,
        "panFront": panFront,
        "DateOfBirth": dateOfBirth,
        "gender": gender,
        "isVerified": isVerified,
        "createdAt": createdAt?.toIso8601String(),
      };
}
