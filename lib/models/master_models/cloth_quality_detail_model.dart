import 'dart:convert';

ClothQualityDetailModel clothQualityDetailModelFromJson(String str) => ClothQualityDetailModel.fromJson(json.decode(str));

String clothQualityDetailModelToJson(ClothQualityDetailModel data) => json.encode(data.toJson());

class ClothQualityDetailModel {
  bool? success;
  String? message;
  Data? data;

  ClothQualityDetailModel({
    this.success,
    this.message,
    this.data,
  });

  factory ClothQualityDetailModel.fromJson(Map<String, dynamic> json) => ClothQualityDetailModel(
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
  int? qualityId;
  String? qualityName;
  String? status;

  Data({
    this.qualityId,
    this.qualityName,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
