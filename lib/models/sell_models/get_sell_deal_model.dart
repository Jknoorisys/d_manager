// To parse this JSON data, do
//
//     final getSellDealModel = getSellDealModelFromJson(jsonString);

import 'dart:convert';

GetSellDealModel getSellDealModelFromJson(String str) => GetSellDealModel.fromJson(json.decode(str));

String getSellDealModelToJson(GetSellDealModel data) => json.encode(data.toJson());

class GetSellDealModel {
  bool? success;
  String? message;
  Data? data;

  GetSellDealModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetSellDealModel.fromJson(Map<String, dynamic> json) => GetSellDealModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
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

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
