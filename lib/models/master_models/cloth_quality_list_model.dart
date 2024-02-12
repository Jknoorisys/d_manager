import 'dart:convert';

ClothQualityListModel clothQualityListModelFromJson(String str) => ClothQualityListModel.fromJson(json.decode(str));

String clothQualityListModelToJson(ClothQualityListModel data) => json.encode(data.toJson());

class ClothQualityListModel {
  bool? success;
  String? message;
  int? total;
  List<ClothQuality>? data;

  ClothQualityListModel({
    this.success,
    this.message,
    this.total,
    this.data,
  });

  factory ClothQualityListModel.fromJson(Map<String, dynamic> json) => ClothQualityListModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    data: json["data"] == null ? [] : List<ClothQuality>.from(json["data"]!.map((x) => ClothQuality.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ClothQuality {
  int? qualityId;
  String? qualityName;
  String? status;

  ClothQuality({
    this.qualityId,
    this.qualityName,
    this.status,
  });

  factory ClothQuality.fromJson(Map<String, dynamic> json) => ClothQuality(
    qualityId: json["quality_id"],
    qualityName: json["quality_name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "quality_id": qualityId,
    "quality_name": qualityName,
    "status": status,
  };
}
