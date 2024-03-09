import 'dart:convert';

AddTransportDetailModel addTransportDetailModelFromJson(String str) => AddTransportDetailModel.fromJson(json.decode(str));

String addTransportDetailModelToJson(AddTransportDetailModel data) => json.encode(data.toJson());

class AddTransportDetailModel {
  bool? success;
  String? message;

  AddTransportDetailModel({
    this.success,
    this.message,
  });

  factory AddTransportDetailModel.fromJson(Map<String, dynamic> json) => AddTransportDetailModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
