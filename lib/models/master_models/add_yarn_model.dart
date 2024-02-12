import 'dart:convert';

AddYarnModel addYarnModelFromJson(String str) => AddYarnModel.fromJson(json.decode(str));

String addYarnModelToJson(AddYarnModel data) => json.encode(data.toJson());

class AddYarnModel {
  bool? success;
  String? message;

  AddYarnModel({
    this.success,
    this.message,
  });

  factory AddYarnModel.fromJson(Map<String, dynamic> json) => AddYarnModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
