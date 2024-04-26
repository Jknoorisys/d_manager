import 'dart:convert';

UnpaidPurchaseModel unpaidPurchaseModelFromJson(String str) => UnpaidPurchaseModel.fromJson(json.decode(str));

String unpaidPurchaseModelToJson(UnpaidPurchaseModel data) => json.encode(data.toJson());

class UnpaidPurchaseModel {
  bool? success;
  String? message;
  int? total;
  dynamic search;
  String? totalUnpaid;
  List<UnpaidPurchaseDetail>? data;

  UnpaidPurchaseModel({
    this.success,
    this.message,
    this.total,
    this.search,
    this.totalUnpaid,
    this.data,
  });

  factory UnpaidPurchaseModel.fromJson(Map<String, dynamic> json) => UnpaidPurchaseModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    search: json["search"],
    totalUnpaid: json["total_unpaid"],
    data: json["data"] == null ? [] : List<UnpaidPurchaseDetail>.from(json["data"]!.map((x) => UnpaidPurchaseDetail.fromJson(x))),
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

class UnpaidPurchaseDetail {
  String? gstBillAmount;
  String? paidAmount;
  String? partyId;
  String? partyName;
  double? totalGstBillAmount;
  int? totalPaidAmount;
  double? unpaidAmount;

  UnpaidPurchaseDetail({
    this.gstBillAmount,
    this.paidAmount,
    this.partyId,
    this.partyName,
    this.totalGstBillAmount,
    this.totalPaidAmount,
    this.unpaidAmount,
  });

  factory UnpaidPurchaseDetail.fromJson(Map<String, dynamic> json) => UnpaidPurchaseDetail(
    gstBillAmount: json["gst_bill_amount"],
    paidAmount: json["paid_amount"],
    partyId: json["party_id"],
    partyName: json["party_name"],
    totalGstBillAmount: json["total_gst_bill_amount"]?.toDouble(),
    totalPaidAmount: json["total_paid_amount"],
    unpaidAmount: json["unpaid_amount"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "gst_bill_amount": gstBillAmount,
    "paid_amount": paidAmount,
    "party_id": partyId,
    "party_name": partyName,
    "total_gst_bill_amount": totalGstBillAmount,
    "total_paid_amount": totalPaidAmount,
    "unpaid_amount": unpaidAmount,
  };
}
