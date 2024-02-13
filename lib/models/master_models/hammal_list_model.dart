import 'dart:convert';

HammalListModel hammalListModelFromJson(String str) => HammalListModel.fromJson(json.decode(str));

String hammalListModelToJson(HammalListModel data) => json.encode(data.toJson());

class HammalListModel {
  bool? success;
  String? message;
  int? total;
  List<HammalDetail>? data;

  HammalListModel({
    this.success,
    this.message,
    this.total,
    this.data,
  });

  factory HammalListModel.fromJson(Map<String, dynamic> json) => HammalListModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    data: json["data"] == null ? [] : List<HammalDetail>.from(json["data"]!.map((x) => HammalDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class HammalDetail {
  int? hammalId;
  String? hammalName;
  String? hammalPhoneNo;
  String? status;

  HammalDetail({
    this.hammalId,
    this.hammalName,
    this.hammalPhoneNo,
    this.status,
  });

  factory HammalDetail.fromJson(Map<String, dynamic> json) => HammalDetail(
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
