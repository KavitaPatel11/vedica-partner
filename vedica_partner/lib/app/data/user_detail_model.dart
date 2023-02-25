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
    this.userId,
    this.fullName,
    this.phone,
    this.email,
    this.city,
    this.profileImage,
    this.isPortfolioCreated,
    this.isBlocked,
    this.createdAt,
  });

  String? userId;
  String? fullName;
  String? phone;
  String? email;
  String? city;
  String? profileImage;
  bool? isPortfolioCreated;
  bool? isBlocked;
  DateTime? createdAt;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        userId: json["userId"],
        fullName: json["fullName"],
        phone: json["phone"],
        email: json["email"],
        city: json["city"],
        profileImage: json["profileImage"],
        isPortfolioCreated: json["isPortfolioCreated"],
        isBlocked: json["isBlocked"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "fullName": fullName,
        "phone": phone,
        "email": email,
        "city": city,
        "profileImage": profileImage,
        "isPortfolioCreated": isPortfolioCreated,
        "isBlocked": isBlocked,
        "createdAt": createdAt?.toIso8601String(),
      };
}
