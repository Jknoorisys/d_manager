// To parse this JSON data, do
//
//     final yarnPaymentDueDateModel = yarnPaymentDueDateModelFromJson(jsonString);

import 'dart:convert';

YarnPaymentDueDateModel yarnPaymentDueDateModelFromJson(String str) => YarnPaymentDueDateModel.fromJson(json.decode(str));

String yarnPaymentDueDateModelToJson(YarnPaymentDueDateModel data) => json.encode(data.toJson());

class YarnPaymentDueDateModel {
  bool? success;
  String? message;
  List<yarnPaymentDueDate>? data;

  YarnPaymentDueDateModel({
    this.success,
    this.message,
    this.data,
  });

  factory YarnPaymentDueDateModel.fromJson(Map<String, dynamic> json) => YarnPaymentDueDateModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<yarnPaymentDueDate>.from(json["data"]!.map((x) => yarnPaymentDueDate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class yarnPaymentDueDate {
  int? yarnPurchaseId;
  DateTime? dueDate;
  String? grossWeight;
  String? rate;
  String? gstBillAmount;
  String? firmName;
  String? partyName;
  String? partyFirmName;
  String? yarnName;
  String? typeName;

  yarnPaymentDueDate({
    this.yarnPurchaseId,
    this.dueDate,
    this.grossWeight,
    this.rate,
    this.gstBillAmount,
    this.firmName,
    this.partyName,
    this.partyFirmName,
    this.yarnName,
    this.typeName,
  });

  factory yarnPaymentDueDate.fromJson(Map<String, dynamic> json) => yarnPaymentDueDate(
    yarnPurchaseId: json["yarn_purchase_id"],
    dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
    grossWeight: json["gross_weight"],
    rate: json["rate"],
    gstBillAmount: json["gst_bill_amount"],
    firmName: json["firm_name"],
    partyName: json["party_name"],
    partyFirmName: json["party_firm_name"],
    yarnName: json["yarn_name"],
    typeName: json["type_name"],
  );

  Map<String, dynamic> toJson() => {
    "yarn_purchase_id": yarnPurchaseId,
    "due_date": "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
    "gross_weight": grossWeight,
    "rate": rate,
    "gst_bill_amount": gstBillAmount,
    "firm_name": firmName,
    "party_name": partyName,
    "party_firm_name": partyFirmName,
    "yarn_name": yarnName,
    "type_name": typeName,
  };
}
