// To parse this JSON data, do
//
//     final InvoiceListModel = InvoiceListModelFromJson(jsonString);

import 'dart:convert';

InvoiceListModel InvoiceListModelFromJson(String str) => InvoiceListModel.fromJson(json.decode(str));

String InvoiceListModelToJson(InvoiceListModel data) => json.encode(data.toJson());

class InvoiceListModel {
  bool? success;
  String? message;
  int? total;
  List<InvoiceDetail>? data;

  InvoiceListModel({
    this.success,
    this.message,
    this.total,
    this.data,
  });

  factory InvoiceListModel.fromJson(Map<String, dynamic> json) => InvoiceListModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    data: json["data"] == null ? [] : List<InvoiceDetail>.from(json["data"]!.map((x) => InvoiceDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class InvoiceDetail {
  int? invoiceId;
  DateTime? invoiceDate;
  String? invoiceNumber;
  String? sellId;
  String? paymentType;
  DateTime? paymentDueDate;
  String? dharaDays;
  String? rate;
  String? discount;
  String? invoiceAmount;
  String? gst;
  DateTime? dueDate;
  String? paidStatus;
  String? receivedAmount;
  String? differenceAmount;
  String? paymentDate;
  String? paymentMethod;
  String? reason;
  String? status;
  String? transportDate;
  String? transportName;
  String? hammalName;
  List<BaleDetail>? baleDetails;

  InvoiceDetail({
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
    this.baleDetails,
  });

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) => InvoiceDetail(
    invoiceId: json["invoice_id"],
    invoiceDate: json["invoice_date"] == null ? null : DateTime.parse(json["invoice_date"]),
    invoiceNumber: json["invoice_number"],
    sellId: json["sell_id"],
    paymentType: json["payment_type"],
    paymentDueDate: json["payment_due_date"] == null ? null : DateTime.parse(json["payment_due_date"]),
    dharaDays: json["dhara_days"],
    rate: json["rate"],
    discount: json["discount"],
    invoiceAmount: json["invoice_amount"],
    gst: json["gst"],
    dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
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
    baleDetails: json["bale_details"] == null ? [] : List<BaleDetail>.from(json["bale_details"]!.map((x) => BaleDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "invoice_id": invoiceId,
    "invoice_date": "${invoiceDate!.year.toString().padLeft(4, '0')}-${invoiceDate!.month.toString().padLeft(2, '0')}-${invoiceDate!.day.toString().padLeft(2, '0')}",
    "invoice_number": invoiceNumber,
    "sell_id": sellId,
    "payment_type": paymentType,
    "payment_due_date": "${paymentDueDate!.year.toString().padLeft(4, '0')}-${paymentDueDate!.month.toString().padLeft(2, '0')}-${paymentDueDate!.day.toString().padLeft(2, '0')}",
    "dhara_days": dharaDays,
    "rate": rate,
    "discount": discount,
    "invoice_amount": invoiceAmount,
    "gst": gst,
    "due_date": "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
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
