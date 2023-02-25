// To parse this JSON data, do
//
//     final bankDetailModel = bankDetailModelFromJson(jsonString);

import 'dart:convert';

BankDetailModel bankDetailModelFromJson(String str) =>
    BankDetailModel.fromJson(json.decode(str));

String bankDetailModelToJson(BankDetailModel data) =>
    json.encode(data.toJson());

class BankDetailModel {
  BankDetailModel({
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

  factory BankDetailModel.fromJson(Map<String, dynamic> json) =>
      BankDetailModel(
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
    this.bankId,
    this.bankName,
    this.accountNumber,
    this.ifsc,
    this.accountHolderName,
    this.isActive,
  });

  String? userId;
  String? bankId;
  String? bankName;
  String? accountNumber;
  String? ifsc;
  String? accountHolderName;
  bool? isActive;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        userId: json["userId"],
        bankId: json["bankId"],
        bankName: json["bankName"],
        accountNumber: json["accountNumber"],
        ifsc: json["ifsc"],
        accountHolderName: json["accountHolderName"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "bankId": bankId,
        "bankName": bankName,
        "accountNumber": accountNumber,
        "ifsc": ifsc,
        "accountHolderName": accountHolderName,
        "isActive": isActive,
      };
}
