// To parse this JSON data, do
//
//     final sellDealListModel = sellDealListModelFromJson(jsonString);

import 'dart:convert';

SellDealListModel sellDealListModelFromJson(String str) => SellDealListModel.fromJson(json.decode(str));

String sellDealListModelToJson(SellDealListModel data) => json.encode(data.toJson());

class SellDealListModel {
  bool? success;
  String? message;
  List<SellListData>? data;

  SellDealListModel({
    this.success,
    this.message,
    this.data,
  });

  factory SellDealListModel.fromJson(Map<String, dynamic> json) => SellDealListModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<SellListData>.from(json["data"]!.map((x) => SellListData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SellListData {
  int? sellId;
  String? sellDate;
  String? firmId;
  String? partyId;
  String? qualityId;
  String? totalThan;
  String? rate;
  String? thanDelivered;
  String? thanRemaining;
  String? dealStatus;
  String? status;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? firmName;
  String? partyFirm;
  String? partyName;
  String? qualityName;

  SellListData({
    this.sellId,
    this.sellDate,
    this.firmId,
    this.partyId,
    this.qualityId,
    this.totalThan,
    this.rate,
    this.thanDelivered,
    this.thanRemaining,
    this.dealStatus,
    this.status,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.firmName,
    this.partyFirm,
    this.partyName,
    this.qualityName,
  });

  factory SellListData.fromJson(Map<String, dynamic> json) => SellListData(
    sellId: json["sell_id"],
    sellDate: json["sell_date"],
    firmId: json["firm_id"],
    partyId: json["party_id"],
    qualityId: json["quality_id"],
    totalThan: json["total_than"],
    rate: json["rate"],
    thanDelivered: json["than_delivered"],
    thanRemaining: json["than_remaining"],
    dealStatus: json["deal_status"],
    status: json["status"],
    createdAt: json["created_at"],
    createdBy: json["created_by"],
    updatedAt: json["updated_at"],
    updatedBy: json["updated_by"],
    firmName: json["firm_name"],
    partyFirm: json["party_firm"],
    partyName: json["party_name"],
    qualityName: json["quality_name"],
  );

  Map<String, dynamic> toJson() => {
    "sell_id": sellId,
    "sell_date": sellDate,
    "firm_id": firmId,
    "party_id": partyId,
    "quality_id": qualityId,
    "total_than": totalThan,
    "rate": rate,
    "than_delivered": thanDelivered,
    "than_remaining": thanRemaining,
    "deal_status": dealStatus,
    "status": status,
    "created_at": createdAt,
    "created_by": createdBy,
    "updated_at": updatedAt,
    "updated_by": updatedBy,
    "firm_name": firmName,
    "party_firm": partyFirm,
    "party_name": partyName,
    "quality_name": qualityName,
  };
}
