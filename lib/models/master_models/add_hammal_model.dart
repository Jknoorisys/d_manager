import 'dart:convert';

AddHammalModel addHammalModelFromJson(String str) => AddHammalModel.fromJson(json.decode(str));

String addHammalModelToJson(AddHammalModel data) => json.encode(data.toJson());

class AddHammalModel {
  bool? success;
  String? message;

  AddHammalModel({
    this.success,
    this.message,
  });

  factory AddHammalModel.fromJson(Map<String, dynamic> json) => AddHammalModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
