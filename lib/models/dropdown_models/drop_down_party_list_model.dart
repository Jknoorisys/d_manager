import 'dart:convert';

DropdownPartyListModel dropdownPartyListModelFromJson(String str) => DropdownPartyListModel.fromJson(json.decode(str));

String dropdownPartyListModelToJson(DropdownPartyListModel data) => json.encode(data.toJson());

class DropdownPartyListModel {
  bool? success;
  String? message;
  List<Party>? data;

  DropdownPartyListModel({
    this.success,
    this.message,
    this.data,
  });

  factory DropdownPartyListModel.fromJson(Map<String, dynamic> json) => DropdownPartyListModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Party>.from(json["data"]!.map((x) => Party.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Party {
  int? partyId;
  String? partyName;

  Party({
    this.partyId,
    this.partyName,
  });

  factory Party.fromJson(Map<String, dynamic> json) => Party(
    partyId: json["party_id"],
    partyName: json["party_name"],
  );

  Map<String, dynamic> toJson() => {
    "party_id": partyId,
    "party_name": partyName,
  };
}
