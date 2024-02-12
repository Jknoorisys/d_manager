import 'dart:convert';

UpdateFirmStatusModel updateFirmStatusModelFromJson(String str) => UpdateFirmStatusModel.fromJson(json.decode(str));

String updateFirmStatusModelToJson(UpdateFirmStatusModel data) => json.encode(data.toJson());

class UpdateFirmStatusModel {
  bool? success;
  String? message;

  UpdateFirmStatusModel({
    this.success,
    this.message,
  });

  factory UpdateFirmStatusModel.fromJson(Map<String, dynamic> json) => UpdateFirmStatusModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
