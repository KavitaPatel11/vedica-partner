// To parse this JSON data, do
//
//     final userDetailModel = userDetailModelFromJson(jsonString);

import 'dart:convert';

UserDetailModel userDetailModelFromJson(String str) =>
    UserDetailModel.fromJson(json.decode(str));

String userDetailModelToJson(UserDetailModel data) =>
    json.encode(data.toJson());

class UserDetailModel {
  UserDetailModel({
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

  factory UserDetailModel.fromJson(Map<String, dynamic> json) =>
      UserDetailModel(
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
    this.token,
    this.profileImage,
    this.fullName,
  });

  String? token;
  String? profileImage;
  String? fullName;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        token: json["token"],
        profileImage: json["profileImage"],
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "profileImage": profileImage,
        "fullName": fullName,
      };
}
