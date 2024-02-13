import 'dart:convert';

UpdateTransportModel updateTransportModelFromJson(String str) => UpdateTransportModel.fromJson(json.decode(str));

String updateTransportModelToJson(UpdateTransportModel data) => json.encode(data.toJson());

class UpdateTransportModel {
  bool? success;
  String? message;

  UpdateTransportModel({
    this.success,
    this.message,
  });

  factory UpdateTransportModel.fromJson(Map<String, dynamic> json) => UpdateTransportModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
