import 'dart:convert';

UnpaidSellModel unpaidSellModelFromJson(String str) => UnpaidSellModel.fromJson(json.decode(str));

String unpaidSellModelToJson(UnpaidSellModel data) => json.encode(data.toJson());

class UnpaidSellModel {
  bool? success;
  String? message;
  int? total;
  dynamic search;
  String? totalUnpaid;
  List<UnpaidSellDetail>? data;

  UnpaidSellModel({
    this.success,
    this.message,
    this.total,
    this.search,
    this.totalUnpaid,
    this.data,
  });

  factory UnpaidSellModel.fromJson(Map<String, dynamic> json) => UnpaidSellModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    search: json["search"],
    totalUnpaid: json["total_unpaid"],
    data: json["data"] == null ? [] : List<UnpaidSellDetail>.from(json["data"]!.map((x) => UnpaidSellDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "search": search,
    "total_unpaid": totalUnpaid,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class UnpaidSellDetail {
  double? differenceAmount;
  String? partyId;
  String? partyName;

  UnpaidSellDetail({
    this.differenceAmount,
    this.partyId,
    this.partyName,
  });

  factory UnpaidSellDetail.fromJson(Map<String, dynamic> json) => UnpaidSellDetail(
    differenceAmount: json["difference_amount"]?.toDouble(),
    partyId: json["party_id"],
    partyName: json["party_name"],
  );

  Map<String, dynamic> toJson() => {
    "difference_amount": differenceAmount,
    "party_id": partyId,
    "party_name": partyName,
  };
}
