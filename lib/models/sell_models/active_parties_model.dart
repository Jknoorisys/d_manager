// To parse this JSON data, do
//
//     final activePartiesModel = activePartiesModelFromJson(jsonString);

import 'dart:convert';

ActivePartiesModel activePartiesModelFromJson(String str) => ActivePartiesModel.fromJson(json.decode(str));

String activePartiesModelToJson(ActivePartiesModel data) => json.encode(data.toJson());

class ActivePartiesModel {
  bool? success;
  String? message;
  List<ActivePartiesList>? data;

  ActivePartiesModel({
    this.success,
    this.message,
    this.data,
  });

  factory ActivePartiesModel.fromJson(Map<String, dynamic> json) => ActivePartiesModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ActivePartiesList>.from(json["data"]!.map((x) => ActivePartiesList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ActivePartiesList {
  int? partyId;
  String? partyName;

  ActivePartiesList({
    this.partyId,
    this.partyName,
  });

  factory ActivePartiesList.fromJson(Map<String, dynamic> json) => ActivePartiesList(
    partyId: json["party_id"],
    partyName: json["party_name"],
  );

  Map<String, dynamic> toJson() => {
    "party_id": partyId,
    "party_name": partyName,
  };
}
