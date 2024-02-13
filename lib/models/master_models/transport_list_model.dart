// To parse this JSON data, do
//
//     final transportListModel = transportListModelFromJson(jsonString);

import 'dart:convert';

TransportListModel transportListModelFromJson(String str) => TransportListModel.fromJson(json.decode(str));

String transportListModelToJson(TransportListModel data) => json.encode(data.toJson());

class TransportListModel {
  bool? success;
  String? message;
  int? total;
  List<TransportDetail>? data;

  TransportListModel({
    this.success,
    this.message,
    this.total,
    this.data,
  });

  factory TransportListModel.fromJson(Map<String, dynamic> json) => TransportListModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    data: json["data"] == null ? [] : List<TransportDetail>.from(json["data"]!.map((x) => TransportDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TransportDetail {
  int? transportId;
  String? transportName;
  String? transportAddress;
  String? transportPhoneNo;
  String? status;

  TransportDetail({
    this.transportId,
    this.transportName,
    this.transportAddress,
    this.transportPhoneNo,
    this.status,
  });

  factory TransportDetail.fromJson(Map<String, dynamic> json) => TransportDetail(
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
