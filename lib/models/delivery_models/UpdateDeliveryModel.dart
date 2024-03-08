import 'dart:convert';

UpdateDeliveryModel updateDeliveryModelFromJson(String str) => UpdateDeliveryModel.fromJson(json.decode(str));

String updateDeliveryModelToJson(UpdateDeliveryModel data) => json.encode(data.toJson());

class UpdateDeliveryModel {
  bool? success;
  String? message;

  UpdateDeliveryModel({
    this.success,
    this.message,
  });

  factory UpdateDeliveryModel.fromJson(Map<String, dynamic> json) => UpdateDeliveryModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
