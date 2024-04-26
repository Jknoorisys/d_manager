import 'dart:convert';

SellInventoryListModel sellInventoryListModelFromJson(String str) => SellInventoryListModel.fromJson(json.decode(str));

String sellInventoryListModelToJson(SellInventoryListModel data) => json.encode(data.toJson());

class SellInventoryListModel {
  bool? success;
  String? message;
  int? total;
  Filter? filter;
  List<SellInventoryDetail>? data;

  SellInventoryListModel({
    this.success,
    this.message,
    this.total,
    this.filter,
    this.data,
  });

  factory SellInventoryListModel.fromJson(Map<String, dynamic> json) => SellInventoryListModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    data: json["data"] == null ? [] : List<SellInventoryDetail>.from(json["data"]!.map((x) => SellInventoryDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "filter": filter?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SellInventoryDetail {
  int? clothInventoryId;
  String? invoiceId;
  String? sellId;
  String? invoiceDate;
  String? qualityId;
  String? totalThan;
  String? roto;
  String? zero;
  String? reason;
  int? status;
  String? createdAt;
  String? createdBy;
  String? qualityName;

  SellInventoryDetail({
    this.clothInventoryId,
    this.invoiceId,
    this.sellId,
    this.invoiceDate,
    this.qualityId,
    this.totalThan,
    this.roto,
    this.zero,
    this.reason,
    this.status,
    this.createdAt,
    this.createdBy,
    this.qualityName,
  });

  factory SellInventoryDetail.fromJson(Map<String, dynamic> json) => SellInventoryDetail(
    clothInventoryId: json["cloth_inventory_id"],
    invoiceId: json["invoice_id"],
    sellId: json["sell_id"],
    invoiceDate: json["invoice_date"],
    qualityId: json["quality_id"],
    totalThan: json["total_than"],
    roto: json["roto"],
    zero: json["zero"],
    reason: json["reason"],
    status: json["status"],
    createdAt: json["created_at"],
    createdBy: json["created_by"],
    qualityName: json["quality_name"],
  );

  Map<String, dynamic> toJson() => {
    "cloth_inventory_id": clothInventoryId,
    "invoice_id": invoiceId,
    "sell_id": sellId,
    "invoice_date": invoiceDate,
    "quality_id": qualityId,
    "total_than": totalThan,
    "roto": roto,
    "zero": zero,
    "reason": reason,
    "status": status,
    "created_at": createdAt,
    "created_by": createdBy,
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
