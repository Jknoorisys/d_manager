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
  DateTime? sellDate;
  DateTime? sellDueDate;
  String? totalThan;
  String? rate;
  String? thanDelivered;
  String? thanRemaining;
  String? dealStatus;
  String? status;
  String? firmId;
  String? firmName;
  String? partyId;
  String? partyFirm;
  String? partyName;
  String? qualityId;
  String? qualityName;

  Data({
    this.sellId,
    this.sellDate,
    this.sellDueDate,
    this.totalThan,
    this.rate,
    this.thanDelivered,
    this.thanRemaining,
    this.dealStatus,
    this.status,
    this.firmId,
    this.firmName,
    this.partyId,
    this.partyFirm,
    this.partyName,
    this.qualityId,
    this.qualityName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sellId: json["sell_id"],
    sellDate: json["sell_date"] == null ? null : DateTime.parse(json["sell_date"]),
    sellDueDate: json["sell_due_date"] == null ? null : DateTime.parse(json["sell_due_date"]),
    totalThan: json["total_than"],
    rate: json["rate"],
    thanDelivered: json["than_delivered"],
    thanRemaining: json["than_remaining"],
    dealStatus: json["deal_status"],
    status: json["status"],
    firmId: json["firm_id"],
    firmName: json["firm_name"],
    partyId: json["party_id"],
    partyFirm: json["party_firm"],
    partyName: json["party_name"],
    qualityId: json["quality_id"],
    qualityName: json["quality_name"],
  );

  Map<String, dynamic> toJson() => {
    "sell_id": sellId,
    "sell_date": "${sellDate!.year.toString().padLeft(4, '0')}-${sellDate!.month.toString().padLeft(2, '0')}-${sellDate!.day.toString().padLeft(2, '0')}",
    "sell_due_date": "${sellDueDate!.year.toString().padLeft(4, '0')}-${sellDueDate!.month.toString().padLeft(2, '0')}-${sellDueDate!.day.toString().padLeft(2, '0')}",
    "total_than": totalThan,
    "rate": rate,
    "than_delivered": thanDelivered,
    "than_remaining": thanRemaining,
    "deal_status": dealStatus,
    "status": status,
    "firm_id": firmId,
    "firm_name": firmName,
    "party_id": partyId,
    "party_firm": partyFirm,
    "party_name": partyName,
    "quality_id": qualityId,
    "quality_name": qualityName,
  };
}
