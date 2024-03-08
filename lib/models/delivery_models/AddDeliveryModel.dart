import 'dart:convert';

AddDeliveryModel addDeliveryModelFromJson(String str) => AddDeliveryModel.fromJson(json.decode(str));

String addDeliveryModelToJson(AddDeliveryModel data) => json.encode(data.toJson());

class AddDeliveryModel {
  bool? success;
  String? message;

  AddDeliveryModel({
    this.success,
    this.message,
  });

  factory AddDeliveryModel.fromJson(Map<String, dynamic> json) => AddDeliveryModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
