import 'dart:convert';

UpdateHammalStatusModel updateHammalStatusModelFromJson(String str) => UpdateHammalStatusModel.fromJson(json.decode(str));

String updateHammalStatusModelToJson(UpdateHammalStatusModel data) => json.encode(data.toJson());

class UpdateHammalStatusModel {
  bool? success;
  String? message;

  UpdateHammalStatusModel({
    this.success,
    this.message,
  });

  factory UpdateHammalStatusModel.fromJson(Map<String, dynamic> json) => UpdateHammalStatusModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
