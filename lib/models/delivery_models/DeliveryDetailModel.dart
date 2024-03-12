// To parse this JSON data, do
//
//     final deliveryDetailModel = deliveryDetailModelFromJson(jsonString);

import 'dart:convert';

DeliveryDetailModel deliveryDetailModelFromJson(String str) => DeliveryDetailModel.fromJson(json.decode(str));

String deliveryDetailModelToJson(DeliveryDetailModel data) => json.encode(data.toJson());

class DeliveryDetailModel {
  bool? success;
  String? message;
  Data? data;

  DeliveryDetailModel({
    this.success,
    this.message,
    this.data,
  });

  factory DeliveryDetailModel.fromJson(Map<String, dynamic> json) => DeliveryDetailModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? yarnPurchaseId;
  String? deliveryDate;
  String? deliveredBoxCount;
  String? rate;
  String? grossWeight;
  String? netWeight;
  String? cops;
  String? denier;
  dynamic purchaseAmount;
  String? paymentType;
  String? paymentDueDate;
  String? dharaDays;
  String? paidStatus;
  dynamic paymentMethod;
  dynamic paymentDate;
  dynamic paymentNotes;
  dynamic paidAmount;
  String? billReceived;
  String? billUrl;
  String? gstBillAmount;

  Data({
    this.yarnPurchaseId,
    this.deliveryDate,
    this.deliveredBoxCount,
    this.rate,
    this.grossWeight,
    this.netWeight,
    this.cops,
    this.denier,
    this.purchaseAmount,
    this.paymentType,
    this.paymentDueDate,
    this.dharaDays,
    this.paidStatus,
    this.paymentMethod,
    this.paymentDate,
    this.paymentNotes,
    this.paidAmount,
    this.billReceived,
    this.billUrl,
    this.gstBillAmount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    yarnPurchaseId: json["yarn_purchase_id"],
    deliveryDate: json["delivery_date"] == null ? null : json["delivery_date"],
    deliveredBoxCount: json["delivered_box_count"],
    rate: json["rate"],
    grossWeight: json["gross_weight"],
    netWeight: json["net_weight"],
    cops: json["cops"],
    denier: json["denier"],
    purchaseAmount: json["purchase_amount"],
    paymentType: json["payment_type"],
    paymentDueDate: json["payment_due_date"] == null ? null : json["payment_due_date"],
    dharaDays: json["dhara_days"],
    paidStatus: json["paid_status"],
    paymentMethod: json["payment_method"],
    paymentDate: json["payment_date"],
    paymentNotes: json["payment_notes"],
    paidAmount: json["paid_amount"],
    billReceived: json["bill_received"],
    billUrl: json["bill_url"],
    gstBillAmount: json["gst_bill_amount"],
  );

  Map<String, dynamic> toJson() => {
    "yarn_purchase_id": yarnPurchaseId,
    "delivery_date": deliveryDate == null ? null : deliveryDate,
    "delivered_box_count": deliveredBoxCount,
    "rate": rate,
    "gross_weight": grossWeight,
    "net_weight": netWeight,
    "cops": cops,
    "denier": denier,
    "purchase_amount": purchaseAmount,
    "payment_type": paymentType,
    "payment_due_date": paymentDueDate == null ? null : paymentDueDate,
    "dhara_days": dharaDays,
    "paid_status": paidStatus,
    "payment_method": paymentMethod,
    "payment_date": paymentDate,
    "payment_notes": paymentNotes,
    "paid_amount": paidAmount,
    "bill_received": billReceived,
    "bill_url": billUrl,
    "gst_bill_amount": gstBillAmount,
  };
}
