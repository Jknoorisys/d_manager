// To parse this JSON data, do
//
//     final updateClothQualityStatusModel = updateClothQualityStatusModelFromJson(jsonString);

import 'dart:convert';

UpdateClothQualityStatusModel updateClothQualityStatusModelFromJson(String str) => UpdateClothQualityStatusModel.fromJson(json.decode(str));

String updateClothQualityStatusModelToJson(UpdateClothQualityStatusModel data) => json.encode(data.toJson());

class UpdateClothQualityStatusModel {
  bool? success;
  String? message;

  UpdateClothQualityStatusModel({
    this.success,
    this.message,
  });

  factory UpdateClothQualityStatusModel.fromJson(Map<String, dynamic> json) => UpdateClothQualityStatusModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
