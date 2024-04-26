// To parse this JSON data, do
//
//     final thansToBeDeliveredModel = thansToBeDeliveredModelFromJson(jsonString);

import 'dart:convert';

ThansToBeDeliveredModel thansToBeDeliveredModelFromJson(String str) => ThansToBeDeliveredModel.fromJson(json.decode(str));

String thansToBeDeliveredModelToJson(ThansToBeDeliveredModel data) => json.encode(data.toJson());

class ThansToBeDeliveredModel {
  bool? success;
  String? message;
  int? total;
  List<ThansPending>? data;

  ThansToBeDeliveredModel({
    this.success,
    this.message,
    this.total,
    this.data,
  });

  factory ThansToBeDeliveredModel.fromJson(Map<String, dynamic> json) => ThansToBeDeliveredModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    data: json["data"] == null ? [] : List<ThansPending>.from(json["data"]!.map((x) => ThansPending.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ThansPending {
  int? sellId;
  DateTime? dueDate;
  String? rate;
  String? totalThan;
  String? thanDelivered;
  String? thanRemaining;
  String? firmName;
  String? partyName;
  String? partyFirmName;
  String? qualityName;

  ThansPending({
    this.sellId,
    this.dueDate,
    this.rate,
    this.totalThan,
    this.thanDelivered,
    this.thanRemaining,
    this.firmName,
    this.partyName,
    this.partyFirmName,
    this.qualityName,
  });

  factory ThansPending.fromJson(Map<String, dynamic> json) => ThansPending(
    sellId: json["sell_id"],
    dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
    rate: json["rate"],
    totalThan: json["total_than"],
    thanDelivered: json["than_delivered"],
    thanRemaining: json["than_remaining"],
    firmName: json["firm_name"],
    partyName: json["party_name"],
    partyFirmName: json["party_firm_name"],
    qualityName: json["quality_name"],
  );

  Map<String, dynamic> toJson() => {
    "sell_id": sellId,
    "due_date": "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
    "rate": rate,
    "total_than": totalThan,
    "than_delivered": thanDelivered,
    "than_remaining": thanRemaining,
    "firm_name": firmName,
    "party_name": partyName,
    "party_firm_name": partyFirmName,
    "quality_name": qualityName,
  };
}
