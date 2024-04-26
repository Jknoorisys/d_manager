import 'dart:convert';

InventoryDetailModel inventoryDetailModelFromJson(String str) => InventoryDetailModel.fromJson(json.decode(str));

String inventoryDetailModelToJson(InventoryDetailModel data) => json.encode(data.toJson());

class InventoryDetailModel {
  bool? success;
  String? message;
  Data? data;

  InventoryDetailModel({
    this.success,
    this.message,
    this.data,
  });

  factory InventoryDetailModel.fromJson(Map<String, dynamic> json) => InventoryDetailModel(
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
  int? clothInventoryId;
  String? invoiceId;
  String? sellId;
  DateTime? invoiceDate;
  String? qualityId;
  String? totalThan;
  String? roto;
  String? zero;
  String? reason;
  int? status;
  String? createdAt;
  String? createdBy;

  Data({
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
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    clothInventoryId: json["cloth_inventory_id"],
    invoiceId: json["invoice_id"],
    sellId: json["sell_id"],
    invoiceDate: json["invoice_date"] == null ? null : DateTime.parse(json["invoice_date"]),
    qualityId: json["quality_id"],
    totalThan: json["total_than"],
    roto: json["roto"],
    zero: json["zero"],
    reason: json["reason"],
    status: json["status"],
    createdAt: json["created_at"],
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "cloth_inventory_id": clothInventoryId,
    "invoice_id": invoiceId,
    "sell_id": sellId,
    "invoice_date": "${invoiceDate!.year.toString().padLeft(4, '0')}-${invoiceDate!.month.toString().padLeft(2, '0')}-${invoiceDate!.day.toString().padLeft(2, '0')}",
    "quality_id": qualityId,
    "total_than": totalThan,
    "roto": roto,
    "zero": zero,
    "reason": reason,
    "status": status,
    "created_at": createdAt,
    "created_by": createdBy,
  };
}
