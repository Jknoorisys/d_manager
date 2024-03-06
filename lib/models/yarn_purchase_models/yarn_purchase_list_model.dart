import 'dart:convert';

YarnPurchaseListModel yarnPurchaseListModelFromJson(String str) => YarnPurchaseListModel.fromJson(json.decode(str));

String yarnPurchaseListModelToJson(YarnPurchaseListModel data) => json.encode(data.toJson());

class YarnPurchaseListModel {
  bool? success;
  String? message;
  int? total;
  Filter? filter;
  List<PurchaseDetail>? data;

  YarnPurchaseListModel({
    this.success,
    this.message,
    this.total,
    this.filter,
    this.data,
  });

  factory YarnPurchaseListModel.fromJson(Map<String, dynamic> json) => YarnPurchaseListModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    data: json["data"] == null ? [] : List<PurchaseDetail>.from(json["data"]!.map((x) => PurchaseDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "filter": filter?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PurchaseDetail {
  int? purchaseId;
  String? partyName;
  String? partyFirm;
  DateTime? purchaseDate;
  String? yarnName;
  String? yarnTypeName;
  String? paymentType;
  String? lotNumber;
  String? orderedBoxCount;
  String? netWeight;
  String? grossReceivedWeight;
  String? grossWeight;
  String? cops;
  String? denier;
  String? rate;
  String? status;

  PurchaseDetail({
    this.purchaseId,
    this.partyName,
    this.partyFirm,
    this.purchaseDate,
    this.yarnName,
    this.yarnTypeName,
    this.paymentType,
    this.lotNumber,
    this.orderedBoxCount,
    this.netWeight,
    this.grossReceivedWeight,
    this.grossWeight,
    this.cops,
    this.denier,
    this.rate,
    this.status,
  });

  factory PurchaseDetail.fromJson(Map<String, dynamic> json) => PurchaseDetail(
    purchaseId: json["purchase_id"],
    partyName: json["party_name"],
    partyFirm: json["party_firm"],
    purchaseDate: json["purchase_date"] == null ? null : DateTime.parse(json["purchase_date"]),
    yarnName: json["yarn_name"],
    yarnTypeName: json["yarn_type_name"],
    paymentType: json["payment_type"],
    lotNumber: json["lot_number"],
    orderedBoxCount: json["ordered_box_count"],
    netWeight: json["net_weight"],
    grossReceivedWeight: json["gross_received_weight"],
    grossWeight: json["gross_weight"],
    cops: json["cops"],
    denier: json["denier"],
    rate: json["rate"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "purchase_id": purchaseId,
    "party_name": partyName,
    "party_firm": partyFirm,
    "purchase_date": "${purchaseDate!.day.toString().padLeft(2, '0')}-${purchaseDate!.month.toString().padLeft(2, '0')}-${purchaseDate!.year.toString().padLeft(4, '0')}",
    "yarn_name": yarnName,
    "yarn_type_name": yarnTypeName,
    "payment_type": paymentType,
    "lot_number": lotNumber,
    "ordered_box_count": orderedBoxCount,
    "net_weight": netWeight,
    "gross_received_weight": grossReceivedWeight,
    "gross_weight": grossWeight,
    "cops": cops,
    "denier": denier,
    "rate": rate,
    "status": status,
  };
}

class Filter {
  dynamic firmId;
  dynamic partyId;
  dynamic yarnTypeId;
  dynamic dealStatus;

  Filter({
    this.firmId,
    this.partyId,
    this.yarnTypeId,
    this.dealStatus,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    firmId: json["firm_id"],
    partyId: json["party_id"],
    yarnTypeId: json["yarn_type_id"],
    dealStatus: json["deal_status"],
  );

  Map<String, dynamic> toJson() => {
    "firm_id": firmId,
    "party_id": partyId,
    "yarn_type_id": yarnTypeId,
    "deal_status": dealStatus,
  };
}
