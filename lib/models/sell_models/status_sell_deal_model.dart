// To parse this JSON data, do
//
//     final updateSellDealStatusModel = updateSellDealStatusModelFromJson(jsonString);

import 'dart:convert';

UpdateSellDealStatusModel updateSellDealStatusModelFromJson(String str) => UpdateSellDealStatusModel.fromJson(json.decode(str));

String updateSellDealStatusModelToJson(UpdateSellDealStatusModel data) => json.encode(data.toJson());

class UpdateSellDealStatusModel {
  bool? success;
  String? message;

  UpdateSellDealStatusModel({
    this.success,
    this.message,
  });

  factory UpdateSellDealStatusModel.fromJson(Map<String, dynamic> json) => UpdateSellDealStatusModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
