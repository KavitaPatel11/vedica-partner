// To parse this JSON data, do
//
//     final allPortfolioModel = allPortfolioModelFromJson(jsonString);

import 'dart:convert';

AllPortfolioModel allPortfolioModelFromJson(String str) =>
    AllPortfolioModel.fromJson(json.decode(str));

String allPortfolioModelToJson(AllPortfolioModel data) =>
    json.encode(data.toJson());

class AllPortfolioModel {
  AllPortfolioModel({
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

  factory AllPortfolioModel.fromJson(Map<String, dynamic> json) =>
      AllPortfolioModel(
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
    this.portfolioId,
    this.investAmount,
    this.interest,
    this.locking,
    this.profit,
    this.isActive,
    this.portfolioDate,
    this.createdAt,
  });

  String? userId;
  String? portfolioId;
  int? investAmount;
  int? interest;
  int? locking;
  int? profit;
  bool? isActive;
  String? portfolioDate;
  String? createdAt;

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        userId: json["userId"],
        portfolioId: json["portfolioId"],
        investAmount: json["investAmount"],
        interest: json["interest"],
        locking: json["locking"],
        profit: json["profit"],
        isActive: json["isActive"],
        portfolioDate: json["portfolioDate"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "portfolioId": portfolioId,
        "investAmount": investAmount,
        "interest": interest,
        "locking": locking,
        "profit": profit,
        "isActive": isActive,
        "portfolioDate": portfolioDate,
        "createdAt": createdAt,
      };
}
