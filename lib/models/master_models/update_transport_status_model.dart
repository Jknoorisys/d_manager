import 'dart:convert';

UpdateTransportStatusModel updateTransportStatusModelFromJson(String str) => UpdateTransportStatusModel.fromJson(json.decode(str));

String updateTransportStatusModelToJson(UpdateTransportStatusModel data) => json.encode(data.toJson());

class UpdateTransportStatusModel {
  bool? success;
  String? message;

  UpdateTransportStatusModel({
    this.success,
    this.message,
  });

  factory UpdateTransportStatusModel.fromJson(Map<String, dynamic> json) => UpdateTransportStatusModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
