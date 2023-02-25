// To parse this JSON data, do
//
//     final allBalanceModel = allBalanceModelFromJson(jsonString);

import 'dart:convert';

AllBalanceModel allBalanceModelFromJson(String str) =>
    AllBalanceModel.fromJson(json.decode(str));

String allBalanceModelToJson(AllBalanceModel data) =>
    json.encode(data.toJson());

class AllBalanceModel {
  AllBalanceModel({
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

  factory AllBalanceModel.fromJson(Map<String, dynamic> json) =>
      AllBalanceModel(
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
    this.investAmount,
    this.profit,
  });

  String? userId;
  int? investAmount;
  int? profit;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        userId: json["userId"],
        investAmount: json["investAmount"],
        profit: json["profit"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "investAmount": investAmount,
        "profit": profit,
      };
}
