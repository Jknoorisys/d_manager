import 'dart:convert';

UpdateHammalModel updateHammalModelFromJson(String str) => UpdateHammalModel.fromJson(json.decode(str));

String updateHammalModelToJson(UpdateHammalModel data) => json.encode(data.toJson());

class UpdateHammalModel {
  bool? success;
  String? message;

  UpdateHammalModel({
    this.success,
    this.message,
  });

  factory UpdateHammalModel.fromJson(Map<String, dynamic> json) => UpdateHammalModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
