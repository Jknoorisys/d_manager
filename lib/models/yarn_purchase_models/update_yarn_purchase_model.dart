import 'dart:convert';

UpdateYarnPurchaseModel updateYarnPurchaseModelFromJson(String str) => UpdateYarnPurchaseModel.fromJson(json.decode(str));

String updateYarnPurchaseModelToJson(UpdateYarnPurchaseModel data) => json.encode(data.toJson());

class UpdateYarnPurchaseModel {
  bool? success;
  String? message;

  UpdateYarnPurchaseModel({
    this.success,
    this.message,
  });

  factory UpdateYarnPurchaseModel.fromJson(Map<String, dynamic> json) => UpdateYarnPurchaseModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
