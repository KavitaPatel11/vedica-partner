// To parse this JSON data, do
//
//     final allTransactionModel = allTransactionModelFromJson(jsonString);

import 'dart:convert';

AllTransactionModel allTransactionModelFromJson(String str) =>
    AllTransactionModel.fromJson(json.decode(str));

String allTransactionModelToJson(AllTransactionModel data) =>
    json.encode(data.toJson());

class AllTransactionModel {
  AllTransactionModel({
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

  factory AllTransactionModel.fromJson(Map<String, dynamic> json) =>
      AllTransactionModel(
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
    this.docs,
    this.totalDocs,
    this.limit,
    this.totalPages,
    this.page,
    this.pagingCounter,
    this.hasPrevPage,
    this.hasNextPage,
    this.prevPage,
    this.nextPage,
  });

  List<Doc>? docs;
  int? totalDocs;
  int? limit;
  int? totalPages;
  int? page;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        docs: json["docs"] == null
            ? []
            : List<Doc>.from(json["docs"]!.map((x) => Doc.fromJson(x))),
        totalDocs: json["totalDocs"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        page: json["page"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "docs": docs == null
            ? []
            : List<dynamic>.from(docs!.map((x) => x.toJson())),
        "totalDocs": totalDocs,
        "limit": limit,
        "totalPages": totalPages,
        "page": page,
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
      };
}

class Doc {
  Doc({
    this.userId,
    this.fullName,
    this.phone,
    this.amount,
    this.type,
    this.reason,
    this.date,
  });

  String? userId;
  String? fullName;
  String? phone;
  int? amount;
  String? type;
  String? reason;
  String? date;

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        userId: json["userId"],
        fullName: json["fullName"],
        phone: json["phone"],
        amount: json["amount"],
        type: json["type"],
        reason: json["reason"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "fullName": fullName,
        "phone": phone,
        "amount": amount,
        "type": type,
        "reason": reason,
        "date": date,
      };
}
