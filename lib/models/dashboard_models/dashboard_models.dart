// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  bool? success;
  String? message;
  Filter? filter;
  double? sellAmount;
  int? purchaseAmount;
  Data? data;

  DashboardModel({
    this.success,
    this.message,
    this.filter,
    this.sellAmount,
    this.purchaseAmount,
    this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    success: json["success"],
    message: json["message"],
    filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    sellAmount: json["sellAmount"]?.toDouble(),
    purchaseAmount: json["purchaseAmount"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "filter": filter?.toJson(),
    "sellAmount": sellAmount,
    "purchaseAmount": purchaseAmount,
    "data": data?.toJson(),
  };
}

class Data {
  List<SellDeal>? sellDeal;
  List<PurchaseDeal>? purchaseDeals;

  Data({
    this.sellDeal,
    this.purchaseDeals,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sellDeal: json["sell_deal"] == null ? [] : List<SellDeal>.from(json["sell_deal"]!.map((x) => SellDeal.fromJson(x))),
    purchaseDeals: json["purchase_deals"] == null ? [] : List<PurchaseDeal>.from(json["purchase_deals"]!.map((x) => PurchaseDeal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sell_deal": sellDeal == null ? [] : List<dynamic>.from(sellDeal!.map((x) => x.toJson())),
    "purchase_deals": purchaseDeals == null ? [] : List<dynamic>.from(purchaseDeals!.map((x) => x.toJson())),
  };
}

class PurchaseDeal {
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
  String? partyFirm;
  String? partyName;
  String? yarnName;
  String? yarnTypeName;

  PurchaseDeal({
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
    this.partyFirm,
    this.partyName,
    this.yarnName,
    this.yarnTypeName,
  });

  factory PurchaseDeal.fromJson(Map<String, dynamic> json) => PurchaseDeal(
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
    partyFirm: json["party_firm"],
    partyName: json["party_name"],
    yarnName: json["yarn_name"],
    yarnTypeName: json["yarn_type_name"],
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
    "party_firm": partyFirm,
    "party_name": partyName,
    "yarn_name": yarnName,
    "yarn_type_name": yarnTypeName,
  };
}

class SellDeal {
  int? sellId;
  String? sellDate;
  String? sellDueDate;
  String? firmId;
  String? partyId;
  String? qualityId;
  String? totalThan;
  String? rate;
  String? thanDelivered;
  String? thanRemaining;
  String? dealStatus;
  String? status;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? firmName;
  String? partyFirm;
  String? partyName;
  String? qualityName;

  SellDeal({
    this.sellId,
    this.sellDate,
    this.sellDueDate,
    this.firmId,
    this.partyId,
    this.qualityId,
    this.totalThan,
    this.rate,
    this.thanDelivered,
    this.thanRemaining,
    this.dealStatus,
    this.status,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.firmName,
    this.partyFirm,
    this.partyName,
    this.qualityName,
  });

  factory SellDeal.fromJson(Map<String, dynamic> json) => SellDeal(
    sellId: json["sell_id"],
    sellDate: json["sell_date"],
    sellDueDate: json["sell_due_date"],
    firmId: json["firm_id"],
    partyId: json["party_id"],
    qualityId: json["quality_id"],
    totalThan: json["total_than"],
    rate: json["rate"],
    thanDelivered: json["than_delivered"],
    thanRemaining: json["than_remaining"],
    dealStatus: json["deal_status"],
    status: json["status"],
    createdAt: json["created_at"],
    createdBy: json["created_by"],
    updatedAt: json["updated_at"],
    updatedBy: json["updated_by"],
    firmName: json["firm_name"],
    partyFirm: json["party_firm"],
    partyName: json["party_name"],
    qualityName: json["quality_name"],
  );

  Map<String, dynamic> toJson() => {
    "sell_id": sellId,
    "sell_date": sellDate,
    "sell_due_date": sellDueDate,
    "firm_id": firmId,
    "party_id": partyId,
    "quality_id": qualityId,
    "total_than": totalThan,
    "rate": rate,
    "than_delivered": thanDelivered,
    "than_remaining": thanRemaining,
    "deal_status": dealStatus,
    "status": status,
    "created_at": createdAt,
    "created_by": createdBy,
    "updated_at": updatedAt,
    "updated_by": updatedBy,
    "firm_name": firmName,
    "party_firm": partyFirm,
    "party_name": partyName,
    "quality_name": qualityName,
  };
}

class Filter {
  String? startDate;
  String? endDate;

  Filter({
    this.startDate,
    this.endDate,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    startDate: json["start_date"],
    endDate: json["end_date"],
  );

  Map<String, dynamic> toJson() => {
    "start_date": startDate,
    "end_date": endDate,
  };
}
