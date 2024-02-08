// To parse this JSON data, do
//
//     final createSellDealModel = createSellDealModelFromJson(jsonString);

import 'dart:convert';

CreateSellDealModel createSellDealModelFromJson(String str) => CreateSellDealModel.fromJson(json.decode(str));

String createSellDealModelToJson(CreateSellDealModel data) => json.encode(data.toJson());

class CreateSellDealModel {
  bool? success;
  String? message;

  CreateSellDealModel({
    this.success,
    this.message,
  });

  factory CreateSellDealModel.fromJson(Map<String, dynamic> json) => CreateSellDealModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
