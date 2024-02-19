import 'dart:convert';

AddYarnPurchaseModel addYarnPurchaseModelFromJson(String str) => AddYarnPurchaseModel.fromJson(json.decode(str));

String addYarnPurchaseModelToJson(AddYarnPurchaseModel data) => json.encode(data.toJson());

class AddYarnPurchaseModel {
  bool? success;
  String? message;

  AddYarnPurchaseModel({
    this.success,
    this.message,
  });

  factory AddYarnPurchaseModel.fromJson(Map<String, dynamic> json) => AddYarnPurchaseModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
