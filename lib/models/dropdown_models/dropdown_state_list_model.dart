import 'dart:convert';

DropdownStateListModel dropdownStateListModelFromJson(String str) => DropdownStateListModel.fromJson(json.decode(str));

String dropdownStateListModelToJson(DropdownStateListModel data) => json.encode(data.toJson());

class DropdownStateListModel {
  bool? success;
  String? message;
  List<StateDetail>? data;

  DropdownStateListModel({
    this.success,
    this.message,
    this.data,
  });

  factory DropdownStateListModel.fromJson(Map<String, dynamic> json) => DropdownStateListModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<StateDetail>.from(json["data"]!.map((x) => StateDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StateDetail {
  int? stateId;
  String? stateCode;
  String? stateName;

  StateDetail({
    this.stateId,
    this.stateCode,
    this.stateName,
  });

  factory StateDetail.fromJson(Map<String, dynamic> json) => StateDetail(
    stateId: json["state_id"],
    stateCode: json["state_code"],
    stateName: json["state_name"],
  );

  Map<String, dynamic> toJson() => {
    "state_id": stateId,
    "state_code": stateCode,
    "state_name": stateName,
  };
}
