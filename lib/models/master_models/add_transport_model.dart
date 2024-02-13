import 'dart:convert';

AddTransportModel addTransportModelFromJson(String str) => AddTransportModel.fromJson(json.decode(str));

String addTransportModelToJson(AddTransportModel data) => json.encode(data.toJson());

class AddTransportModel {
  bool? success;
  String? message;

  AddTransportModel({
    this.success,
    this.message,
  });

  factory AddTransportModel.fromJson(Map<String, dynamic> json) => AddTransportModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
