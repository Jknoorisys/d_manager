import 'dart:convert';

DropdownHammalListModel dropdownHammalListModelFromJson(String str) => DropdownHammalListModel.fromJson(json.decode(str));

String dropdownHammalListModelToJson(DropdownHammalListModel data) => json.encode(data.toJson());

class DropdownHammalListModel {
  bool? success;
  String? message;
  List<Hammal>? data;

  DropdownHammalListModel({
    this.success,
    this.message,
    this.data,
  });

  factory DropdownHammalListModel.fromJson(Map<String, dynamic> json) => DropdownHammalListModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Hammal>.from(json["data"]!.map((x) => Hammal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Hammal {
  int? hammalId;
  String? hammalName;

  Hammal({
    this.hammalId,
    this.hammalName,
  });

  factory Hammal.fromJson(Map<String, dynamic> json) => Hammal(
    hammalId: json["hammal_id"],
    hammalName: json["hammal_name"],
  );

  Map<String, dynamic> toJson() => {
    "hammal_id": hammalId,
    "hammal_name": hammalName,
  };
}
