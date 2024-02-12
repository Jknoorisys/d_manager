import 'dart:convert';

UpdateYarnStatusModel updateYarnStatusModelFromJson(String str) => UpdateYarnStatusModel.fromJson(json.decode(str));

String updateYarnStatusModelToJson(UpdateYarnStatusModel data) => json.encode(data.toJson());

class UpdateYarnStatusModel {
  bool? success;
  String? message;

  UpdateYarnStatusModel({
    this.success,
    this.message,
  });

  factory UpdateYarnStatusModel.fromJson(Map<String, dynamic> json) => UpdateYarnStatusModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
