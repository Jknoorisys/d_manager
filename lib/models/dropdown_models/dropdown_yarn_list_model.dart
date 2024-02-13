import 'dart:convert';

DropdownYarnListModel dropdownYarnListModelFromJson(String str) => DropdownYarnListModel.fromJson(json.decode(str));

String dropdownYarnListModelToJson(DropdownYarnListModel data) => json.encode(data.toJson());

class DropdownYarnListModel {
  bool? success;
  String? message;
  List<Yarn>? data;

  DropdownYarnListModel({
    this.success,
    this.message,
    this.data,
  });

  factory DropdownYarnListModel.fromJson(Map<String, dynamic> json) => DropdownYarnListModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Yarn>.from(json["data"]!.map((x) => Yarn.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Yarn {
  int? yarnTypeId;
  String? yarnName;
  String? typeName;

  Yarn({
    this.yarnTypeId,
    this.yarnName,
    this.typeName,
  });

  factory Yarn.fromJson(Map<String, dynamic> json) => Yarn(
    yarnTypeId: json["yarn_type_id"],
    yarnName: json["yarn_name"],
    typeName: json["type_name"],
  );

  Map<String, dynamic> toJson() => {
    "yarn_type_id": yarnTypeId,
    "yarn_name": yarnName,
    "type_name": typeName,
  };
}
