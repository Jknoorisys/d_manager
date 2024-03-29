// To parse this JSON data, do
//
//     final sellDealListModel = sellDealListModelFromJson(jsonString);

import 'dart:convert';

SellDealListModel sellDealListModelFromJson(String str) => SellDealListModel.fromJson(json.decode(str));

String sellDealListModelToJson(SellDealListModel data) => json.encode(data.toJson());

class SellDealListModel {
  bool? success;
  String? message;
  int? total;
  Filter? filter;
  List<SellDeal>? data;

  SellDealListModel({
    this.success,
    this.message,
    this.total,
    this.filter,
    this.data,
  });

  factory SellDealListModel.fromJson(Map<String, dynamic> json) => SellDealListModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    data: json["data"] == null ? [] : List<SellDeal>.from(json["data"]!.map((x) => SellDeal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "filter": filter?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SellDeal {
  int? sellId;
  DateTime? sellDate;
  DateTime? sellDueDate;
  String? firmId;
  String? firmName;
  String? partyId;
  String? partyFirm;
  String? partyName;
  String? qualityId;
  String? qualityName;
  String? totalThan;
  String? rate;
  String? thanDelivered;
  String? thanRemaining;
  String? dealStatus;
  String? status;

  SellDeal({
    this.sellId,
    this.sellDate,
    this.sellDueDate,
    this.firmId,
    this.firmName,
    this.partyId,
    this.partyFirm,
    this.partyName,
    this.qualityId,
    this.qualityName,
    this.totalThan,
    this.rate,
    this.thanDelivered,
    this.thanRemaining,
    this.dealStatus,
    this.status,
  });

  factory SellDeal.fromJson(Map<String, dynamic> json) => SellDeal(
    sellId: json["sell_id"],
    sellDate: json["sell_date"] == null ? null : DateTime.parse(json["sell_date"]),
    sellDueDate: json["sell_due_date"] == null ? null : DateTime.parse(json["sell_due_date"]),
    firmId: json["firm_id"],
    firmName: json["firm_name"],
    partyId: json["party_id"],
    partyFirm: json["party_firm"],
    partyName: json["party_name"],
    qualityId: json["quality_id"],
    qualityName: json["quality_name"],
    totalThan: json["total_than"],
    rate: json["rate"],
    thanDelivered: json["than_delivered"],
    thanRemaining: json["than_remaining"],
    dealStatus: json["deal_status"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "sell_id": sellId,
    "sell_date": "${sellDate!.year.toString().padLeft(4, '0')}-${sellDate!.month.toString().padLeft(2, '0')}-${sellDate!.day.toString().padLeft(2, '0')}",
    "sell_due_date": "${sellDueDate!.year.toString().padLeft(4, '0')}-${sellDueDate!.month.toString().padLeft(2, '0')}-${sellDueDate!.day.toString().padLeft(2, '0')}",
    "firm_id": firmId,
    "firm_name": firmName,
    "party_id": partyId,
    "party_firm": partyFirm,
    "party_name": partyName,
    "quality_id": qualityId,
    "quality_name": qualityName,
    "total_than": totalThan,
    "rate": rate,
    "than_delivered": thanDelivered,
    "than_remaining": thanRemaining,
    "deal_status": dealStatus,
    "status": status,
  };
}

class Filter {
  String? firmId;
  String? partyId;
  String? qualityId;
  String? dealStatus;

  Filter({
    this.firmId,
    this.partyId,
    this.qualityId,
    this.dealStatus,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    firmId: json["firm_id"],
    partyId: json["party_id"],
    qualityId: json["quality_id"],
    dealStatus: json["deal_status"],
  );

  Map<String, dynamic> toJson() => {
    "firm_id": firmId,
    "party_id": partyId,
    "quality_id": qualityId,
    "deal_status": dealStatus,
  };
}
