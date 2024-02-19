// To parse this JSON data, do
//
//     final sellHistoryModel = sellHistoryModelFromJson(jsonString);

import 'dart:convert';

SellHistoryModel sellHistoryModelFromJson(String str) => SellHistoryModel.fromJson(json.decode(str));

String sellHistoryModelToJson(SellHistoryModel data) => json.encode(data.toJson());

class SellHistoryModel {
  bool? success;
  String? message;
  int? total;
  Filter? filter;
  List<SellHistoryModelList>? data;

  SellHistoryModel({
    this.success,
    this.message,
    this.total,
    this.filter,
    this.data,
  });

  factory SellHistoryModel.fromJson(Map<String, dynamic> json) => SellHistoryModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    data: json["data"] == null ? [] : List<SellHistoryModelList>.from(json["data"]!.map((x) => SellHistoryModelList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "filter": filter?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SellHistoryModelList {
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
  int? invoiceCount;
  int? totalMeter;
  int? totalGstAmount;
  int? totalInvoiceAmount;
  int? totalReceivedAmount;
  int? totalDifferenceAmount;

  SellHistoryModelList({
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
    this.invoiceCount,
    this.totalMeter,
    this.totalGstAmount,
    this.totalInvoiceAmount,
    this.totalReceivedAmount,
    this.totalDifferenceAmount,
  });

  factory SellHistoryModelList.fromJson(Map<String, dynamic> json) => SellHistoryModelList(
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
    invoiceCount: json["invoice_count"],
    totalMeter: json["total_meter"],
    totalGstAmount: json["total_gst_amount"],
    totalInvoiceAmount: json["total_invoice_amount"],
    totalReceivedAmount: json["total_received_amount"],
    totalDifferenceAmount: json["total_difference_amount"],
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
    "invoice_count": invoiceCount,
    "total_meter": totalMeter,
    "total_gst_amount": totalGstAmount,
    "total_invoice_amount": totalInvoiceAmount,
    "total_received_amount": totalReceivedAmount,
    "total_difference_amount": totalDifferenceAmount,
  };
}

class Filter {
  dynamic firmId;
  dynamic partyId;
  dynamic qualityId;
  dynamic dealStatus;

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
