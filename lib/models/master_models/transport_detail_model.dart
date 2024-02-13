import 'dart:convert';

TransportDetailModel transportDetailModelFromJson(String str) => TransportDetailModel.fromJson(json.decode(str));

String transportDetailModelToJson(TransportDetailModel data) => json.encode(data.toJson());

class TransportDetailModel {
  bool? success;
  String? message;
  Data? data;

  TransportDetailModel({
    this.success,
    this.message,
    this.data,
  });

  factory TransportDetailModel.fromJson(Map<String, dynamic> json) => TransportDetailModel(
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
  int? transportId;
  String? transportName;
  String? transportAddress;
  String? transportPhoneNo;
  String? status;

  Data({
    this.transportId,
    this.transportName,
    this.transportAddress,
    this.transportPhoneNo,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    transportId: json["transport_id"],
    transportName: json["transport_name"],
    transportAddress: json["transport_address"],
    transportPhoneNo: json["transport_phone_no"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "transport_id": transportId,
    "transport_name": transportName,
    "transport_address": transportAddress,
    "transport_phone_no": transportPhoneNo,
    "status": status,
  };
}
