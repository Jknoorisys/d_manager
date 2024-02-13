import 'dart:convert';

DropdownFirmListModel dropdownFirmListModelFromJson(String str) => DropdownFirmListModel.fromJson(json.decode(str));

String dropdownFirmListModelToJson(DropdownFirmListModel data) => json.encode(data.toJson());

class DropdownFirmListModel {
  bool? success;
  String? message;
  List<Firm>? data;

  DropdownFirmListModel({
    this.success,
    this.message,
    this.data,
  });

  factory DropdownFirmListModel.fromJson(Map<String, dynamic> json) => DropdownFirmListModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Firm>.from(json["data"]!.map((x) => Firm.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Firm {
  int? firmId;
  String? firmName;

  Firm({
    this.firmId,
    this.firmName,
  });

  factory Firm.fromJson(Map<String, dynamic> json) => Firm(
    firmId: json["firm_id"],
    firmName: json["firm_name"],
  );

  Map<String, dynamic> toJson() => {
    "firm_id": firmId,
    "firm_name": firmName,
  };
}
