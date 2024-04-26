import 'dart:convert';

PurchaseHistoryModel purchaseHistoryModelFromJson(String str) => PurchaseHistoryModel.fromJson(json.decode(str));

String purchaseHistoryModelToJson(PurchaseHistoryModel data) => json.encode(data.toJson());

class PurchaseHistoryModel {
  bool? success;
  String? message;
  int? total;
  Filter? filter;
  List<PurchaseHistoryList>? data;

  PurchaseHistoryModel({
    this.success,
    this.message,
    this.total,
    this.filter,
    this.data,
  });

  factory PurchaseHistoryModel.fromJson(Map<String, dynamic> json) => PurchaseHistoryModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    data: json["data"] == null ? [] : List<PurchaseHistoryList>.from(json["data"]!.map((x) => PurchaseHistoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "filter": filter?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PurchaseHistoryList {
  int? purchaseDeliveryId;
  String? userId;
  int? yarnPurchaseId;
  String? deliveryDate;
  String? rate;
  String? grossWeight;
  String? netWeight;
  String? purchaseAmount;
  String? gstBillAmount;
  String? paidAmount;
  String? paymentType;
  String? paymentDueDate;
  String? paidStatus;
  String? paymentDate;
  String? billUrl;
  String? firmId;
  String? firmName;
  String? partyId;
  String? partyName;
  String? yarnTypeId;
  String? yarnName;
  String? typeName;

  PurchaseHistoryList({
    this.purchaseDeliveryId,
    this.userId,
    this.yarnPurchaseId,
    this.deliveryDate,
    this.rate,
    this.grossWeight,
    this.netWeight,
    this.purchaseAmount,
    this.gstBillAmount,
    this.paidAmount,
    this.paymentType,
    this.paymentDueDate,
    this.paidStatus,
    this.paymentDate,
    this.billUrl,
    this.firmId,
    this.firmName,
    this.partyId,
    this.partyName,
    this.yarnTypeId,
    this.yarnName,
    this.typeName,
  });

  factory PurchaseHistoryList.fromJson(Map<String, dynamic> json) => PurchaseHistoryList(
    purchaseDeliveryId: json["purchase_delivery_id"],
    userId: json["user_id"],
    yarnPurchaseId: json["yarn_purchase_id"],
    deliveryDate: json["delivery_date"],
    rate: json["rate"],
    grossWeight: json["gross_weight"],
    netWeight: json["net_weight"],
    purchaseAmount: json["purchase_amount"],
    gstBillAmount: json["gst_bill_amount"],
    paidAmount: json["paid_amount"],
    paymentType: json["payment_type"],
    paymentDueDate: json["payment_due_date"],
    paidStatus: json["paid_status"],
    paymentDate: json["payment_date"],
    billUrl: json["bill_url"],
    firmId: json["firm_id"],
    firmName: json["firm_name"],
    partyId: json["party_id"],
    partyName: json["party_name"],
    yarnTypeId: json["yarn_type_id"],
    yarnName: json["yarn_name"],
    typeName: json["type_name"],
  );

  Map<String, dynamic> toJson() => {
    "purchase_delivery_id": purchaseDeliveryId,
    "user_id": userId,
    "yarn_purchase_id": yarnPurchaseId,
    "delivery_date": deliveryDate,
    "rate": rate,
    "gross_weight": grossWeight,
    "net_weight": netWeight,
    "purchase_amount": purchaseAmount,
    "gst_bill_amount": gstBillAmount,
    "paid_amount": paidAmount,
    "payment_type": paymentType,
    "payment_due_date": paymentDueDate,
    "paid_status": paidStatus,
    "payment_date": paymentDate,
    "bill_url": billUrl,
    "firm_id": firmId,
    "firm_name": firmName,
    "party_id": partyId,
    "party_name": partyName,
    "yarn_type_id": yarnTypeId,
    "yarn_name": yarnName,
    "type_name": typeName,
  };
}

class Filter {
  dynamic firmId;
  dynamic partyId;
  dynamic yarnTypeId;
  dynamic startDate;
  dynamic endDate;

  Filter({
    this.firmId,
    this.partyId,
    this.yarnTypeId,
    this.startDate,
    this.endDate,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    firmId: json["firm_id"],
    partyId: json["party_id"],
    yarnTypeId: json["yarn_type_id"],
    startDate: json["start_date"],
    endDate: json["end_date"],
  );

  Map<String, dynamic> toJson() => {
    "firm_id": firmId,
    "party_id": partyId,
    "yarn_type_id": yarnTypeId,
    "start_date": startDate,
    "end_date": endDate,
  };
}