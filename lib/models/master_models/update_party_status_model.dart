import 'dart:convert';

UpdatePartyStatusModel updatePartyStatusModelFromJson(String str) => UpdatePartyStatusModel.fromJson(json.decode(str));

String updatePartyStatusModelToJson(UpdatePartyStatusModel data) => json.encode(data.toJson());

class UpdatePartyStatusModel {
  bool? success;
  String? message;

  UpdatePartyStatusModel({
    this.success,
    this.message,
  });

  factory UpdatePartyStatusModel.fromJson(Map<String, dynamic> json) => UpdatePartyStatusModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
