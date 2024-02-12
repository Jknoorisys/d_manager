import 'dart:convert';

YarnDetailModel yarnDetailModelFromJson(String str) => YarnDetailModel.fromJson(json.decode(str));

String yarnDetailModelToJson(YarnDetailModel data) => json.encode(data.toJson());

class YarnDetailModel {
  bool? success;
  String? message;
  Data? data;

  YarnDetailModel({
    this.success,
    this.message,
    this.data,
  });

  factory YarnDetailModel.fromJson(Map<String, dynamic> json) => YarnDetailModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? yarnTypeId;
  String? yarnName;
  String? typeName;
  String? status;

  Data({
    this.yarnTypeId,
    this.yarnName,
    this.typeName,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    yarnTypeId: json["yarn_type_id"],
    yarnName: json["yarn_name"],
    typeName: json["type_name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "yarn_type_id": yarnTypeId,
    "yarn_name": yarnName,
    "type_name": typeName,
    "status": status,
  };
}
