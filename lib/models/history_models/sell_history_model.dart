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
  int? invoiceId;
  String? userId;
  String? sellId;
  DateTime? invoiceDate;
  String? invoiceNumber;
  String? paymentType;
  DateTime? paymentDueDate;
  String? rate;
  String? discount;
  String? invoiceAmount;
  String? totalThan;
  String? totalMeter;
  String? gst;
  DateTime? dueDate;
  String? paidStatus;
  String? receivedAmount;
  String? differenceAmount;
  dynamic paymentDate;
  dynamic paymentMethod;
  String? firmId;
  String? firmName;
  String? partyId;
  String? partyName;
  String? qualityId;
  String? qualityName;
  String? baleNumber;

  SellHistoryModelList({
    this.invoiceId,
    this.userId,
    this.sellId,
    this.invoiceDate,
    this.invoiceNumber,
    this.paymentType,
    this.paymentDueDate,
    this.rate,
    this.discount,
    this.invoiceAmount,
    this.totalThan,
    this.totalMeter,
    this.gst,
    this.dueDate,
    this.paidStatus,
    this.receivedAmount,
    this.differenceAmount,
    this.paymentDate,
    this.paymentMethod,
    this.firmId,
    this.firmName,
    this.partyId,
    this.partyName,
    this.qualityId,
    this.qualityName,
    this.baleNumber,
  });

  factory SellHistoryModelList.fromJson(Map<String, dynamic> json) => SellHistoryModelList(
    invoiceId: json["invoice_id"],
    userId: json["user_id"],
    sellId: json["sell_id"],
    invoiceDate: json["invoice_date"] == null ? null : DateTime.parse(json["invoice_date"]),
    invoiceNumber: json["invoice_number"],
    paymentType: json["payment_type"],
    paymentDueDate: json["payment_due_date"] == null ? null : DateTime.parse(json["payment_due_date"]),
    rate: json["rate"],
    discount: json["discount"],
    invoiceAmount: json["invoice_amount"],
    totalThan: json["total_than"],
    totalMeter: json["total_meter"],
    gst: json["gst"],
    dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
    paidStatus: json["paid_status"],
    receivedAmount: json["received_amount"],
    differenceAmount: json["difference_amount"],
    paymentDate: json["payment_date"],
    paymentMethod: json["payment_method"],
    firmId: json["firm_id"],
    firmName: json["firm_name"],
    partyId: json["party_id"],
    partyName: json["party_name"],
    qualityId: json["quality_id"],
    qualityName: json["quality_name"],
    baleNumber: json["bale_number"],
  );

  Map<String, dynamic> toJson() => {
    "invoice_id": invoiceId,
    "user_id": userId,
    "sell_id": sellId,
    "invoice_date": "${invoiceDate!.year.toString().padLeft(4, '0')}-${invoiceDate!.month.toString().padLeft(2, '0')}-${invoiceDate!.day.toString().padLeft(2, '0')}",
    "invoice_number": invoiceNumber,
    "payment_type": paymentType,
    "payment_due_date": "${paymentDueDate!.year.toString().padLeft(4, '0')}-${paymentDueDate!.month.toString().padLeft(2, '0')}-${paymentDueDate!.day.toString().padLeft(2, '0')}",
    "rate": rate,
    "discount": discount,
    "invoice_amount": invoiceAmount,
    "total_than": totalThan,
    "total_meter": totalMeter,
    "gst": gst,
    "due_date": "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
    "paid_status": paidStatus,
    "received_amount": receivedAmount,
    "difference_amount": differenceAmount,
    "payment_date": paymentDate,
    "payment_method": paymentMethod,
    "firm_id": firmId,
    "firm_name": firmName,
    "party_id": partyId,
    "party_name": partyName,
    "quality_id": qualityId,
    "quality_name": qualityName,
    "bale_number": baleNumber,
  };
}

class Filter {
  dynamic firmId;
  dynamic partyId;
  dynamic qualityId;
  dynamic startDate;
  dynamic endDate;

  Filter({
    this.firmId,
    this.partyId,
    this.qualityId,
    this.startDate,
    this.endDate,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    firmId: json["firm_id"],
    partyId: json["party_id"],
    qualityId: json["quality_id"],
    startDate: json["start_date"],
    endDate: json["end_date"],
  );

  Map<String, dynamic> toJson() => {
    "firm_id": firmId,
    "party_id": partyId,
    "quality_id": qualityId,
    "start_date": startDate,
    "end_date": endDate,
  };
}
