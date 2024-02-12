import 'dart:convert';

UpdatePartyModel updatePartyModelFromJson(String str) => UpdatePartyModel.fromJson(json.decode(str));

String updatePartyModelToJson(UpdatePartyModel data) => json.encode(data.toJson());

class UpdatePartyModel {
  bool? success;
  String? message;

  UpdatePartyModel({
    this.success,
    this.message,
  });

  factory UpdatePartyModel.fromJson(Map<String, dynamic> json) => UpdatePartyModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
