import 'dart:convert';

UpdateFirmModel updateFirmModelFromJson(String str) => UpdateFirmModel.fromJson(json.decode(str));

String updateFirmModelToJson(UpdateFirmModel data) => json.encode(data.toJson());

class UpdateFirmModel {
  bool? success;
  String? message;

  UpdateFirmModel({
    this.success,
    this.message,
  });

  factory UpdateFirmModel.fromJson(Map<String, dynamic> json) => UpdateFirmModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
