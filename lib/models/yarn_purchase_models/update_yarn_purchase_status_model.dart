import 'dart:convert';

UpdateYarnPurchaseStatusModel updateYarnPurchaseStatusModelFromJson(String str) => UpdateYarnPurchaseStatusModel.fromJson(json.decode(str));

String updateYarnPurchaseStatusModelToJson(UpdateYarnPurchaseStatusModel data) => json.encode(data.toJson());

class UpdateYarnPurchaseStatusModel {
  bool? success;
  String? message;

  UpdateYarnPurchaseStatusModel({
    this.success,
    this.message,
  });

  factory UpdateYarnPurchaseStatusModel.fromJson(Map<String, dynamic> json) => UpdateYarnPurchaseStatusModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
