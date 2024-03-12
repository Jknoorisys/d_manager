// To parse this JSON data, do
//
//     final gstReturnAmountModel = gstReturnAmountModelFromJson(jsonString);

import 'dart:convert';

GstReturnAmountModel gstReturnAmountModelFromJson(String str) => GstReturnAmountModel.fromJson(json.decode(str));

String gstReturnAmountModelToJson(GstReturnAmountModel data) => json.encode(data.toJson());

class GstReturnAmountModel {
  bool? success;
  String? message;
  Filter? filter;
  Data? data;

  GstReturnAmountModel({
    this.success,
    this.message,
    this.filter,
    this.data,
  });

  factory GstReturnAmountModel.fromJson(Map<String, dynamic> json) => GstReturnAmountModel(
    success: json["success"],
    message: json["message"],
    filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "filter": filter?.toJson(),
    "data": data?.toJson(),
  };
}

class Data {
  double? currentMonthReturn;
  double? lastMonthReturn;

  Data({
    this.currentMonthReturn,
    this.lastMonthReturn,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentMonthReturn: json["current_month_return"]?.toDouble(),
    lastMonthReturn: json["last_month_return"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "current_month_return": currentMonthReturn,
    "last_month_return": lastMonthReturn,
  };
}

class Filter {
  String? month;
  String? year;
  int? lastMonth;
  String? lastYear;

  Filter({
    this.month,
    this.year,
    this.lastMonth,
    this.lastYear,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    month: json["month"],
    year: json["year"],
    lastMonth: json["last_month"],
    lastYear: json["last_year"],
  );

  Map<String, dynamic> toJson() => {
    "month": month,
    "year": year,
    "last_month": lastMonth,
    "last_year": lastYear,
  };
}
