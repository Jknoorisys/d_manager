import 'dart:convert';

AddPartyModel addPartyModelFromJson(String str) => AddPartyModel.fromJson(json.decode(str));

String addPartyModelToJson(AddPartyModel data) => json.encode(data.toJson());

class AddPartyModel {
  bool? success;
  String? message;

  AddPartyModel({
    this.success,
    this.message,
  });

  factory AddPartyModel.fromJson(Map<String, dynamic> json) => AddPartyModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
