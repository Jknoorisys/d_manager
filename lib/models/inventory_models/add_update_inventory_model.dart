import 'dart:convert';

AddUpdateInventoryModel addUpdateInventoryModelFromJson(String str) => AddUpdateInventoryModel.fromJson(json.decode(str));

String addUpdateInventoryModelToJson(AddUpdateInventoryModel data) => json.encode(data.toJson());

class AddUpdateInventoryModel {
  bool? success;
  String? message;

  AddUpdateInventoryModel({
    this.success,
    this.message,
  });

  factory AddUpdateInventoryModel.fromJson(Map<String, dynamic> json) => AddUpdateInventoryModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}