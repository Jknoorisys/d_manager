import 'dart:convert';

DropdownTransportListModel dropdownTransportListModelFromJson(String str) => DropdownTransportListModel.fromJson(json.decode(str));

String dropdownTransportListModelToJson(DropdownTransportListModel data) => json.encode(data.toJson());

class DropdownTransportListModel {
  bool? success;
  String? message;
  List<Transport>? data;

  DropdownTransportListModel({
    this.success,
    this.message,
    this.data,
  });

  factory DropdownTransportListModel.fromJson(Map<String, dynamic> json) => DropdownTransportListModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Transport>.from(json["data"]!.map((x) => Transport.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Transport {
  int? transportId;
  String? transportName;

  Transport({
    this.transportId,
    this.transportName,
  });

  factory Transport.fromJson(Map<String, dynamic> json) => Transport(
    transportId: json["transport_id"],
    transportName: json["transport_name"],
  );

  Map<String, dynamic> toJson() => {
    "transport_id": transportId,
    "transport_name": transportName,
  };
}
