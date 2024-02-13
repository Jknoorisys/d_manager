import 'dart:convert';

HammalDetailModel hammalDetailModelFromJson(String str) => HammalDetailModel.fromJson(json.decode(str));

String hammalDetailModelToJson(HammalDetailModel data) => json.encode(data.toJson());

class HammalDetailModel {
  bool? success;
  String? message;
  Data? data;

  HammalDetailModel({
    this.success,
    this.message,
    this.data,
  });

  factory HammalDetailModel.fromJson(Map<String, dynamic> json) => HammalDetailModel(
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
  int? hammalId;
  String? hammalName;
  String? hammalPhoneNo;
  String? status;

  Data({
    this.hammalId,
    this.hammalName,
    this.hammalPhoneNo,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    hammalId: json["hammal_id"],
    hammalName: json["hammal_name"],
    hammalPhoneNo: json["hammal_phone_no"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "hammal_id": hammalId,
    "hammal_name": hammalName,
    "hammal_phone_no": hammalPhoneNo,
    "status": status,
  };
}
