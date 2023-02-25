// To parse this JSON data, do
//
//     final nomineeDetailModel = nomineeDetailModelFromJson(jsonString);

import 'dart:convert';

NomineeDetailModel nomineeDetailModelFromJson(String str) =>
    NomineeDetailModel.fromJson(json.decode(str));

String nomineeDetailModelToJson(NomineeDetailModel data) =>
    json.encode(data.toJson());

class NomineeDetailModel {
  NomineeDetailModel({
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

  factory NomineeDetailModel.fromJson(Map<String, dynamic> json) =>
      NomineeDetailModel(
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
    this.phone,
    this.email,
    this.nomineeRelation,
    this.nomineeAadhaarNo,
  });

  String? userId;
  String? name;
  String? phone;
  String? email;
  String? nomineeRelation;
  String? nomineeAadhaarNo;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        userId: json["userId"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        nomineeRelation: json["nomineeRelation"],
        nomineeAadhaarNo: json["nomineeAadhaarNo"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "phone": phone,
        "email": email,
        "nomineeRelation": nomineeRelation,
        "nomineeAadhaarNo": nomineeAadhaarNo,
      };
}
