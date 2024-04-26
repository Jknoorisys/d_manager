import 'dart:convert';

PurchaseInventoryListModel purchaseInventoryListModelFromJson(String str) => PurchaseInventoryListModel.fromJson(json.decode(str));

String purchaseInventoryListModelToJson(PurchaseInventoryListModel data) => json.encode(data.toJson());

class PurchaseInventoryListModel {
  bool? success;
  String? message;
  int? total;
  Filter? filter;
  List<PurchaseInventoryDetail>? data;

  PurchaseInventoryListModel({
    this.success,
    this.message,
    this.total,
    this.filter,
    this.data,
  });

  factory PurchaseInventoryListModel.fromJson(Map<String, dynamic> json) => PurchaseInventoryListModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    data: json["data"] == null ? [] : List<PurchaseInventoryDetail>.from(json["data"]!.map((x) => PurchaseInventoryDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "filter": filter?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PurchaseInventoryDetail {
  int? yarnInventoryId;
  String? purchaseId;
  String? purchaseDeliveryId;
  String? deliveryDate;
  String? yarnName;
  String? typeName;
  String? netWeight;

  PurchaseInventoryDetail({
    this.yarnInventoryId,
    this.purchaseId,
    this.purchaseDeliveryId,
    this.deliveryDate,
    this.yarnName,
    this.typeName,
    this.netWeight,
  });

  factory PurchaseInventoryDetail.fromJson(Map<String, dynamic> json) => PurchaseInventoryDetail(
    yarnInventoryId: json["yarn_inventory_id"],
    purchaseId: json["purchase_id"],
    purchaseDeliveryId: json["purchase_delivery_id"],
    deliveryDate: json["delivery_date"],
    yarnName: json["yarn_name"],
    typeName: json["type_name"],
    netWeight: json["net_weight"],
  );

  Map<String, dynamic> toJson() => {
    "yarn_inventory_id": yarnInventoryId,
    "purchase_id": purchaseId,
    "purchase_delivery_id": purchaseDeliveryId,
    "delivery_date": deliveryDate,
    "yarn_name": yarnName,
    "type_name": typeName,
    "net_weight": netWeight,
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
