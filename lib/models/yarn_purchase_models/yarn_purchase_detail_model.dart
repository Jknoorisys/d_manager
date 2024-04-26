import 'dart:convert';

YarnPurchaseDetailModel yarnPurchaseDetailModelFromJson(String str) => YarnPurchaseDetailModel.fromJson(json.decode(str));

String yarnPurchaseDetailModelToJson(YarnPurchaseDetailModel data) => json.encode(data.toJson());

class YarnPurchaseDetailModel {
  bool? success;
  String? message;
  Data? data;

  YarnPurchaseDetailModel({
    this.success,
    this.message,
    this.data,
  });

  factory YarnPurchaseDetailModel.fromJson(Map<String, dynamic> json) => YarnPurchaseDetailModel(
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
  int? purchaseId;
  String? purchaseDate;
  String? firmId;
  String? firmName;
  String? partyId;
  String? partyName;
  String? yarnTypeId;
  String? yarnName;
  String? typeName;
  String? lotNumber;
  String? netWeight;
  String? grossReceivedWeight;
  String? grossWeight;
  String? rate;
  String? denier;
  String? cops;
  String? paymentType;
  String? paymentDueDate;
  String? dharaDays;
  String? status;
  String? dealStatus;

  Data({
    this.purchaseId,
    this.purchaseDate,
    this.firmId,
    this.firmName,
    this.partyId,
    this.partyName,
    this.yarnTypeId,
    this.yarnName,
    this.typeName,
    this.lotNumber,
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
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    purchaseId: json["purchase_id"],
    purchaseDate: json["purchase_date"],
    firmId: json["firm_id"],
    firmName: json["firm_name"],
    partyId: json["party_id"],
    partyName: json["party_name"],
    yarnTypeId: json["yarn_type_id"],
    yarnName: json["yarn_name"],
    typeName: json["type_name"],
    lotNumber: json["lot_number"],
    netWeight: json["net_weight"],
    grossReceivedWeight: json["gross_received_weight"],
    grossWeight: json["gross_weight"],
    rate: json["rate"],
    denier: json["denier"],
    cops: json["cops"],
    paymentType: json["payment_type"],
    paymentDueDate: json["payment_due_date"],
    dharaDays: json["dhara_days"],
    status: json["status"],
    dealStatus: json["deal_status"],
  );

  Map<String, dynamic> toJson() => {
    "purchase_id": purchaseId,
    "purchase_date": purchaseDate,
    "firm_id": firmId,
    "firm_name": firmName,
    "party_id": partyId,
    "party_name": partyName,
    "yarn_type_id": yarnTypeId,
    "yarn_name": yarnName,
    "type_name": typeName,
    "lot_number": lotNumber,
    "net_weight": netWeight,
    "gross_received_weight": grossReceivedWeight,
    "gross_weight": grossWeight,
    "rate": rate,
    "denier": denier,
    "cops": cops,
    "payment_type": paymentType,
    "payment_due_date": paymentDueDate,
    "dhara_days": dharaDays,
    "status": status,
    "deal_status": dealStatus,
  };
}