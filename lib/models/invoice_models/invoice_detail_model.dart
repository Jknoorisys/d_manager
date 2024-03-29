// To parse this JSON data, do
//
//     final getInvoiceModel = getInvoiceModelFromJson(jsonString);

import 'dart:convert';

GetInvoiceModel getInvoiceModelFromJson(String str) => GetInvoiceModel.fromJson(json.decode(str));

String getInvoiceModelToJson(GetInvoiceModel data) => json.encode(data.toJson());

class GetInvoiceModel {
  bool? success;
  String? message;
  Data? data;

  GetInvoiceModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetInvoiceModel.fromJson(Map<String, dynamic> json) => GetInvoiceModel(
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
  int? invoiceId;
  String? invoiceDate;
  String? invoiceNumber;
  String? sellId;
  String? paymentType;
  String? paymentDueDate;
  dynamic dharaDays;
  String? rate;
  String? discount;
  String? invoiceAmount;
  String? gst;
  String? dueDate;
  String? paidStatus;
  String? receivedAmount;
  String? differenceAmount;
  dynamic paymentDate;
  dynamic paymentMethod;
  dynamic reason;
  String? status;
  String? transportDate;
  String? transportName;
  String? hammalName;

  TransportDetails? transportDetails;
  List<BaleDetail>? baleDetails;

  Data({
    this.invoiceId,
    this.invoiceDate,
    this.invoiceNumber,
    this.sellId,
    this.paymentType,
    this.paymentDueDate,
    this.dharaDays,
    this.rate,
    this.discount,
    this.invoiceAmount,
    this.gst,
    this.dueDate,
    this.paidStatus,
    this.receivedAmount,
    this.differenceAmount,
    this.paymentDate,
    this.paymentMethod,
    this.reason,
    this.status,
    this.transportDate,
    this.transportName,
    this.hammalName,
    this.transportDetails,
    this.baleDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    invoiceId: json["invoice_id"],
    invoiceDate: json["invoice_date"],
    invoiceNumber: json["invoice_number"],
    sellId: json["sell_id"],
    paymentType: json["payment_type"],
    paymentDueDate: json["payment_due_date"],
    dharaDays: json["dhara_days"],
    rate: json["rate"],
    discount: json["discount"],
    invoiceAmount: json["invoice_amount"],
    gst: json["gst"],
    dueDate: json["due_date"],
    paidStatus: json["paid_status"],
    receivedAmount: json["received_amount"],
    differenceAmount: json["difference_amount"],
    paymentDate: json["payment_date"],
    paymentMethod: json["payment_method"],
    reason: json["reason"],
    status: json["status"],
    transportDate: json["transport_date"],
    transportName: json["transport_name"],
    hammalName: json["hammal_name"],
    transportDetails: json["transport_details"] == null ? null : TransportDetails.fromJson(json["transport_details"]),
    baleDetails: json["bale_details"] == null ? [] : List<BaleDetail>.from(json["bale_details"]!.map((x) => BaleDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "invoice_id": invoiceId,
    "invoice_date": invoiceDate,
    "invoice_number": invoiceNumber,
    "sell_id": sellId,
    "payment_type": paymentType,
    "payment_due_date": paymentDueDate,
    "dhara_days": dharaDays,
    "rate": rate,
    "discount": discount,
    "invoice_amount": invoiceAmount,
    "gst": gst,
    "due_date": dueDate,
    "paid_status": paidStatus,
    "received_amount": receivedAmount,
    "difference_amount": differenceAmount,
    "payment_date": paymentDate,
    "payment_method": paymentMethod,
    "reason": reason,
    "status": status,
    "transport_date": transportDate,
    "transport_name": transportName,
    "hammal_name": hammalName,
    "transport_details": transportDetails == null ? null : transportDetails!.toJson(),
    "bale_details": baleDetails == null ? [] : List<dynamic>.from(baleDetails!.map((x) => x.toJson())),
  };
}

class BaleDetail {
  String? baleNumber;
  String? than;
  String? meter;

  BaleDetail({
    this.baleNumber,
    this.than,
    this.meter,
  });

  factory BaleDetail.fromJson(Map<String, dynamic> json) => BaleDetail(
    baleNumber: json["bale_number"],
    than: json["than"],
    meter: json["meter"],
  );

  Map<String, dynamic> toJson() => {
    "bale_number": baleNumber,
    "than": than,
    "meter": meter,
  };
}

class TransportDetails {
  String? transportDate;
  String? transportName;
  String? hammalName;

  TransportDetails({
    this.transportDate,
    this.transportName,
    this.hammalName,
  });

  factory TransportDetails.fromJson(Map<String, dynamic> json) => TransportDetails(
    transportDate: json["transport_date"],
    transportName: json["transport_name"],
    hammalName: json["hammal_name"],
  );

  Map<String, dynamic> toJson() => {
    "transport_date": transportDate,
    "transport_name": transportName,
    "hammal_name": hammalName,
  };
}

