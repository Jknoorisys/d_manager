// To parse this JSON data, do
//
//     final activeFirmsModel = activeFirmsModelFromJson(jsonString);

import 'dart:convert';

ActiveFirmsModel activeFirmsModelFromJson(String str) => ActiveFirmsModel.fromJson(json.decode(str));

String activeFirmsModelToJson(ActiveFirmsModel data) => json.encode(data.toJson());

class ActiveFirmsModel {
  bool? success;
  String? message;
  List<ActiveFirmsList>? data;

  ActiveFirmsModel({
    this.success,
    this.message,
    this.data,
  });

  factory ActiveFirmsModel.fromJson(Map<String, dynamic> json) => ActiveFirmsModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ActiveFirmsList>.from(json["data"]!.map((x) => ActiveFirmsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ActiveFirmsList {
  int? firmId;
  String? firmName;

  ActiveFirmsList({
    this.firmId,
    this.firmName,
  });

  factory ActiveFirmsList.fromJson(Map<String, dynamic> json) => ActiveFirmsList(
    firmId: json["firm_id"],
    firmName: json["firm_name"],
  );

  Map<String, dynamic> toJson() => {
    "firm_id": firmId,
    "firm_name": firmName,
  };
}
