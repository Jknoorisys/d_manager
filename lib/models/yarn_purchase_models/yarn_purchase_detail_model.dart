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
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? firmName;
  String? partyName;
  String? partyFirmName;
  String? yarnName;
  String? typeName;

  Data({
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
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.firmName,
    this.partyName,
    this.partyFirmName,
    this.yarnName,
    this.typeName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    createdAt: json["created_at"],
    createdBy: json["created_by"],
    updatedAt: json["updated_at"],
    updatedBy: json["updated_by"],
    firmName: json["firm_name"],
    partyName: json["party_name"],
    partyFirmName: json["party_firm_name"],
    yarnName: json["yarn_name"],
    typeName: json["type_name"],
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
    "created_at": createdAt,
    "created_by": createdBy,
    "updated_at": updatedAt,
    "updated_by": updatedBy,
    "firm_name": firmName,
    "party_name": partyName,
    "party_firm_name": partyFirmName,
    "yarn_name": yarnName,
    "type_name": typeName,
  };
}
