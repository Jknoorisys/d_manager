import 'dart:convert';

ReadNotificationModel readNotificationModelFromJson(String str) => ReadNotificationModel.fromJson(json.decode(str));

String readNotificationModelToJson(ReadNotificationModel data) => json.encode(data.toJson());

class ReadNotificationModel {
  bool? success;
  String? message;

  ReadNotificationModel({
    this.success,
    this.message,
  });

  factory ReadNotificationModel.fromJson(Map<String, dynamic> json) => ReadNotificationModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
