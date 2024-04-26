// To parse this JSON data, do
//
//     final paymentToBeReceivedModel = paymentToBeReceivedModelFromJson(jsonString);

import 'dart:convert';

PaymentToBeReceivedModel paymentToBeReceivedModelFromJson(String str) => PaymentToBeReceivedModel.fromJson(json.decode(str));

String paymentToBeReceivedModelToJson(PaymentToBeReceivedModel data) => json.encode(data.toJson());

class PaymentToBeReceivedModel {
  bool? success;
  String? message;
  int? total;
  List<PaymentReceived>? data;

  PaymentToBeReceivedModel({
    this.success,
    this.message,
    this.total,
    this.data,
  });

  factory PaymentToBeReceivedModel.fromJson(Map<String, dynamic> json) => PaymentToBeReceivedModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    data: json["data"] == null ? [] : List<PaymentReceived>.from(json["data"]!.map((x) => PaymentReceived.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PaymentReceived {
  String? sellId;
  DateTime? dueDate;
  String? invoiceAmount;
  String? totalThan;
  String? totalMeter;
  String? rate;
  String? firmName;
  String? partyName;
  String? partyFirmName;
  String? qualityName;

  PaymentReceived({
    this.sellId,
    this.dueDate,
    this.invoiceAmount,
    this.totalThan,
    this.totalMeter,
    this.rate,
    this.firmName,
    this.partyName,
    this.partyFirmName,
    this.qualityName,
  });

  factory PaymentReceived.fromJson(Map<String, dynamic> json) => PaymentReceived(
    sellId: json["sell_id"],
    dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
    invoiceAmount: json["invoice_amount"],
    totalThan: json["total_than"],
    totalMeter: json["total_meter"],
    rate: json["rate"],
    firmName: json["firm_name"],
    partyName: json["party_name"],
    partyFirmName: json["party_firm_name"],
    qualityName: json["quality_name"],
  );

  Map<String, dynamic> toJson() => {
    "sell_id": sellId,
    "due_date": "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
    "invoice_amount": invoiceAmount,
    "total_than": totalThan,
    "total_meter": totalMeter,
    "rate": rate,
    "firm_name": firmName,
    "party_name": partyName,
    "party_firm_name": partyFirmName,
    "quality_name": qualityName,
  };
}
