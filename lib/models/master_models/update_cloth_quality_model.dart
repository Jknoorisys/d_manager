import 'dart:convert';

UpdateClothQualityModel updateClothQualityModelFromJson(String str) => UpdateClothQualityModel.fromJson(json.decode(str));

String updateClothQualityModelToJson(UpdateClothQualityModel data) => json.encode(data.toJson());

class UpdateClothQualityModel {
  bool? success;
  String? message;

  UpdateClothQualityModel({
    this.success,
    this.message,
  });

  factory UpdateClothQualityModel.fromJson(Map<String, dynamic> json) => UpdateClothQualityModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
