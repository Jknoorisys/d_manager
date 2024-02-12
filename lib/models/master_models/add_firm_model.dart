import 'dart:convert';

AddFirmModel addFirmModelFromJson(String str) => AddFirmModel.fromJson(json.decode(str));

String addFirmModelToJson(AddFirmModel data) => json.encode(data.toJson());

class AddFirmModel {
  bool? success;
  String? message;

  AddFirmModel({
    this.success,
    this.message,
  });

  factory AddFirmModel.fromJson(Map<String, dynamic> json) => AddFirmModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
