import 'dart:convert';

YarnToBeReceivedModel yarnToBeReceivedModelFromJson(String str) => YarnToBeReceivedModel.fromJson(json.decode(str));

String yarnToBeReceivedModelToJson(YarnToBeReceivedModel data) => json.encode(data.toJson());

class YarnToBeReceivedModel {
  bool? success;
  String? message;
  int? total;
  List<YarnToBeReceivedReminderList>? data;

  YarnToBeReceivedModel({
    this.success,
    this.message,
    this.total,
    this.data,
  });

  factory YarnToBeReceivedModel.fromJson(Map<String, dynamic> json) => YarnToBeReceivedModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    data: json["data"] == null ? [] : List<YarnToBeReceivedReminderList>.from(json["data"]!.map((x) => YarnToBeReceivedReminderList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class YarnToBeReceivedReminderList {
  int? purchaseId;
  String? grossReceivedWeight;
  String? grossWeight;
  String? rate;
  DateTime? dueDate;
  String? firmName;
  String? partyName;
  String? partyFirmName;
  String? yarnName;
  String? typeName;

  YarnToBeReceivedReminderList({
    this.purchaseId,
    this.grossReceivedWeight,
    this.grossWeight,
    this.rate,
    this.dueDate,
    this.firmName,
    this.partyName,
    this.partyFirmName,
    this.yarnName,
    this.typeName,
  });

  factory YarnToBeReceivedReminderList.fromJson(Map<String, dynamic> json) => YarnToBeReceivedReminderList(
    purchaseId: json["purchase_id"],
    grossReceivedWeight: json["gross_received_weight"],
    grossWeight: json["gross_weight"],
    rate: json["rate"],
    dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
    firmName: json["firm_name"],
    partyName: json["party_name"],
    partyFirmName: json["party_firm_name"],
    yarnName: json["yarn_name"],
    typeName: json["type_name"],
  );

  Map<String, dynamic> toJson() => {
    "purchase_id": purchaseId,
    "gross_received_weight": grossReceivedWeight,
    "gross_weight": grossWeight,
    "rate": rate,
    "due_date": "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
    "firm_name": firmName,
    "party_name": partyName,
    "party_firm_name": partyFirmName,
    "yarn_name": yarnName,
    "type_name": typeName,
  };
}
