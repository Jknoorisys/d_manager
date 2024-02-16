// To parse this JSON data, do
//
//     final purchaseHistoryModel = purchaseHistoryModelFromJson(jsonString);

import 'dart:convert';

PurchaseHistoryModel purchaseHistoryModelFromJson(String str) => PurchaseHistoryModel.fromJson(json.decode(str));

String purchaseHistoryModelToJson(PurchaseHistoryModel data) => json.encode(data.toJson());

class PurchaseHistoryModel {
  bool? success;
  String? message;
  int? total;
  Filter? filter;
  List<PurchaseHistoryList>? data;

  PurchaseHistoryModel({
    this.success,
    this.message,
    this.total,
    this.filter,
    this.data,
  });

  factory PurchaseHistoryModel.fromJson(Map<String, dynamic> json) => PurchaseHistoryModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    data: json["data"] == null ? [] : List<PurchaseHistoryList>.from(json["data"]!.map((x) => PurchaseHistoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "filter": filter?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PurchaseHistoryList {
  int? purchaseId;
  DateTime? purchaseDate;
  String? firmId;
  String? partyId;
  String? yarnTypeId;
  String? lotNumber;
  String? orderedBoxCount;
  String? deliveredBoxCount;
  String? netWeight;
  String? grossReceivedWeight;
  String? grossWeight;
  String? rate;
  String? denier;
  String? cops;
  String? paymentType;
  DateTime? paymentDueDate;
  String? dharaDays;
  String? status;
  String? dealStatus;
  String? firmName;
  String? partyName;
  String? yarnName;
  String? yarnTypeName;
  int? totalDeliveries;
  int? totalDeliveryBox;
  int? totalGrossWeight;
  double? totalNetWeight;
  int? totalBillAmount;
  int? totalPaidAmount;
  int? totalCops;
  int? totalDenier;

  PurchaseHistoryList({
    this.purchaseId,
    this.purchaseDate,
    this.firmId,
    this.partyId,
    this.yarnTypeId,
    this.lotNumber,
    this.orderedBoxCount,
    this.deliveredBoxCount,
    this.netWeight,
    this.grossReceivedWeight,
    this.grossWeight,
    this.rate,
    this.denier,
    this.cops,
    this.paymentType,
    this.paymentDueDate,
    this.dharaDays,
    this.status,
    this.dealStatus,
    this.firmName,
    this.partyName,
    this.yarnName,
    this.yarnTypeName,
    this.totalDeliveries,
    this.totalDeliveryBox,
    this.totalGrossWeight,
    this.totalNetWeight,
    this.totalBillAmount,
    this.totalPaidAmount,
    this.totalCops,
    this.totalDenier,
  });

  factory PurchaseHistoryList.fromJson(Map<String, dynamic> json) => PurchaseHistoryList(
    purchaseId: json["purchase_id"],
    purchaseDate: json["purchase_date"] == null ? null : DateTime.parse(json["purchase_date"]),
    firmId: json["firm_id"],
    partyId: json["party_id"],
    yarnTypeId: json["yarn_type_id"],
    lotNumber: json["lot_number"],
    orderedBoxCount: json["ordered_box_count"],
    deliveredBoxCount: json["delivered_box_count"],
    netWeight: json["net_weight"],
    grossReceivedWeight: json["gross_received_weight"],
    grossWeight: json["gross_weight"],
    rate: json["rate"],
    denier: json["denier"],
    cops: json["cops"],
    paymentType: json["payment_type"],
    paymentDueDate: json["payment_due_date"] == null ? null : DateTime.parse(json["payment_due_date"]),
    dharaDays: json["dhara_days"],
    status: json["status"],
    dealStatus: json["deal_status"],
    firmName: json["firm_name"],
    partyName: json["party_name"],
    yarnName: json["yarn_name"],
    yarnTypeName: json["yarn_type_name"],
    totalDeliveries: json["total_deliveries"],
    totalDeliveryBox: json["total_delivery_box"],
    totalGrossWeight: json["total_gross_weight"],
    totalNetWeight: json["total_net_weight"]?.toDouble(),
    totalBillAmount: json["total_bill_amount"],
    totalPaidAmount: json["total_paid_amount"],
    totalCops: json["total_cops"],
    totalDenier: json["total_denier"],
  );

  Map<String, dynamic> toJson() => {
    "purchase_id": purchaseId,
    "purchase_date": "${purchaseDate!.year.toString().padLeft(4, '0')}-${purchaseDate!.month.toString().padLeft(2, '0')}-${purchaseDate!.day.toString().padLeft(2, '0')}",
    "firm_id": firmId,
    "party_id": partyId,
    "yarn_type_id": yarnTypeId,
    "lot_number": lotNumber,
    "ordered_box_count": orderedBoxCount,
    "delivered_box_count": deliveredBoxCount,
    "net_weight": netWeight,
    "gross_received_weight": grossReceivedWeight,
    "gross_weight": grossWeight,
    "rate": rate,
    "denier": denier,
    "cops": cops,
    "payment_type": paymentType,
    "payment_due_date": "${paymentDueDate!.year.toString().padLeft(4, '0')}-${paymentDueDate!.month.toString().padLeft(2, '0')}-${paymentDueDate!.day.toString().padLeft(2, '0')}",
    "dhara_days": dharaDays,
    "status": status,
    "deal_status": dealStatus,
    "firm_name": firmName,
    "party_name": partyName,
    "yarn_name": yarnName,
    "yarn_type_name": yarnTypeName,
    "total_deliveries": totalDeliveries,
    "total_delivery_box": totalDeliveryBox,
    "total_gross_weight": totalGrossWeight,
    "total_net_weight": totalNetWeight,
    "total_bill_amount": totalBillAmount,
    "total_paid_amount": totalPaidAmount,
    "total_cops": totalCops,
    "total_denier": totalDenier,
  };
}

class Filter {
  dynamic firmId;
  dynamic partyId;
  dynamic yarnTypeId;
  String? startDate;
  String? endDate;

  Filter({
    this.firmId,
    this.partyId,
    this.yarnTypeId,
    this.startDate,
    this.endDate,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    firmId: json["firm_id"],
    partyId: json["party_id"],
    yarnTypeId: json["yarn_type_id"],
    startDate: json["start_date"],
    endDate: json["end_date"],
  );

  Map<String, dynamic> toJson() => {
    "firm_id": firmId,
    "party_id": partyId,
    "yarn_type_id": yarnTypeId,
    "start_date": startDate,
    "end_date": endDate,
  };
}
