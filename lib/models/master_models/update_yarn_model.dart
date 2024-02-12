import 'dart:convert';

UpdateYarnModel updateYarnModelFromJson(String str) => UpdateYarnModel.fromJson(json.decode(str));

String updateYarnModelToJson(UpdateYarnModel data) => json.encode(data.toJson());

class UpdateYarnModel {
  bool? success;
  String? message;

  UpdateYarnModel({
    this.success,
    this.message,
  });

  factory UpdateYarnModel.fromJson(Map<String, dynamic> json) => UpdateYarnModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
