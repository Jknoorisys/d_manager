import 'dart:convert';

AddClothQualityModel addClothQualityModelFromJson(String str) => AddClothQualityModel.fromJson(json.decode(str));

String addClothQualityModelToJson(AddClothQualityModel data) => json.encode(data.toJson());

class AddClothQualityModel {
  bool? success;
  String? message;

  AddClothQualityModel({
    this.success,
    this.message,
  });

  factory AddClothQualityModel.fromJson(Map<String, dynamic> json) => AddClothQualityModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
