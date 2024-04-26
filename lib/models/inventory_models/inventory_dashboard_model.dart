import 'dart:convert';

InventoryDashboardModel inventoryDashboardModelFromJson(String str) => InventoryDashboardModel.fromJson(json.decode(str));

String inventoryDashboardModelToJson(InventoryDashboardModel data) => json.encode(data.toJson());

class InventoryDashboardModel {
  bool? success;
  String? message;
  InventoryDetail? data;

  InventoryDashboardModel({
    this.success,
    this.message,
    this.data,
  });

  factory InventoryDashboardModel.fromJson(Map<String, dynamic> json) => InventoryDashboardModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : InventoryDetail.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class InventoryDetail {
  double? rotoReceived;
  double? rotoConsumed;
  double? rotoRemaining;
  double? zeroReceived;
  double? zeroConsumed;
  double? zeroRemaining;

  InventoryDetail({
    this.rotoReceived,
    this.rotoConsumed,
    this.rotoRemaining,
    this.zeroReceived,
    this.zeroConsumed,
    this.zeroRemaining,
  });

  factory InventoryDetail.fromJson(Map<String, dynamic> json) => InventoryDetail(
    rotoReceived: json["roto-received"]?.toDouble(),
    rotoConsumed: json["roto-consumed"]?.toDouble(),
    rotoRemaining: json["roto-remaining"]?.toDouble(),
    zeroReceived: json["zero-received"]?.toDouble(),
    zeroConsumed: json["zero-consumed"]?.toDouble(),
    zeroRemaining: json["zero-remaining"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "roto-received": rotoReceived,
    "roto-consumed": rotoConsumed,
    "roto-remaining": rotoRemaining,
    "zero-received": zeroReceived,
    "zero-consumed": zeroConsumed,
    "zero-remaining": zeroRemaining,
  };
}
