import 'dart:convert';

YarnListModel yarnListModelFromJson(String str) => YarnListModel.fromJson(json.decode(str));

String yarnListModelToJson(YarnListModel data) => json.encode(data.toJson());

class YarnListModel {
  bool? success;
  String? message;
  int? total;
  List<YarnDetail>? data;

  YarnListModel({
    this.success,
    this.message,
    this.total,
    this.data,
  });

  factory YarnListModel.fromJson(Map<String, dynamic> json) => YarnListModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    data: json["data"] == null ? [] : List<YarnDetail>.from(json["data"]!.map((x) => YarnDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class YarnDetail {
  int? yarnTypeId;
  String? yarnName;
  String? typeName;
  String? status;

  YarnDetail({
    this.yarnTypeId,
    this.yarnName,
    this.typeName,
    this.status,
  });

  factory YarnDetail.fromJson(Map<String, dynamic> json) => YarnDetail(
    yarnTypeId: json["yarn_type_id"],
    yarnName: json["yarn_name"],
    typeName: json["type_name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "yarn_type_id": yarnTypeId,
    "yarn_name": yarnName,
    "type_name": typeName,
    "status": status,
  };
}
