// To parse this JSON data, do
//
//     final customResponseModel = customResponseModelFromJson(jsonString);

import 'dart:convert';

CustomResponseModel customResponseModelFromJson(String str) =>
    CustomResponseModel.fromJson(json.decode(str));

String customResponseModelToJson(CustomResponseModel data) =>
    json.encode(data.toJson());

class CustomResponseModel {
  CustomResponseModel({
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

  factory CustomResponseModel.fromJson(Map<String, dynamic> json) =>
      CustomResponseModel(
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
    this.isOnboarded,
  });

  String? token;
  String? profileImage;
  bool? isOnboarded;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        token: json["token"],
        profileImage: json["profileImage"],
        isOnboarded: json["isOnboarded"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "profileImage": profileImage,
        "isOnboarded": isOnboarded,
      };
}
