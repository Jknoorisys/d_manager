// To parse this JSON data, do
//
//     final updateDeliveryStatusModel = updateDeliveryStatusModelFromJson(jsonString);

import 'dart:convert';

UpdateDeliveryStatusModel updateDeliveryStatusModelFromJson(String str) => UpdateDeliveryStatusModel.fromJson(json.decode(str));

String updateDeliveryStatusModelToJson(UpdateDeliveryStatusModel data) => json.encode(data.toJson());

class UpdateDeliveryStatusModel {
  bool? success;
  String? message;

  UpdateDeliveryStatusModel({
    this.success,
    this.message,
  });

  factory UpdateDeliveryStatusModel.fromJson(Map<String, dynamic> json) => UpdateDeliveryStatusModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
