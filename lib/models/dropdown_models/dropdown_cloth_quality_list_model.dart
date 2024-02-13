import 'dart:convert';

DropdownClothQualityListModel dropdownClothQualityListModelFromJson(String str) => DropdownClothQualityListModel.fromJson(json.decode(str));

String dropdownClothQualityListModelToJson(DropdownClothQualityListModel data) => json.encode(data.toJson());

class DropdownClothQualityListModel {
  bool? success;
  String? message;
  List<ClothQuality>? data;

  DropdownClothQualityListModel({
    this.success,
    this.message,
    this.data,
  });

  factory DropdownClothQualityListModel.fromJson(Map<String, dynamic> json) => DropdownClothQualityListModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ClothQuality>.from(json["data"]!.map((x) => ClothQuality.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ClothQuality {
  int? qualityId;
  String? qualityName;

  ClothQuality({
    this.qualityId,
    this.qualityName,
  });

  factory ClothQuality.fromJson(Map<String, dynamic> json) => ClothQuality(
    qualityId: json["quality_id"],
    qualityName: json["quality_name"],
  );

  Map<String, dynamic> toJson() => {
    "quality_id": qualityId,
    "quality_name": qualityName,
  };
}
