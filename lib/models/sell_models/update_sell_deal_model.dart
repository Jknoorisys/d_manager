// To parse this JSON data, do
//
//     final updateSellDealModel = updateSellDealModelFromJson(jsonString);

import 'dart:convert';

UpdateSellDealModel updateSellDealModelFromJson(String str) => UpdateSellDealModel.fromJson(json.decode(str));

String updateSellDealModelToJson(UpdateSellDealModel data) => json.encode(data.toJson());

class UpdateSellDealModel {
  bool? success;
  String? message;

  UpdateSellDealModel({
    this.success,
    this.message,
  });

  factory UpdateSellDealModel.fromJson(Map<String, dynamic> json) => UpdateSellDealModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
