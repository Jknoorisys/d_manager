import 'dart:convert';

DeliveryListModel deliveryListModelFromJson(String str) => DeliveryListModel.fromJson(json.decode(str));

String deliveryListModelToJson(DeliveryListModel data) => json.encode(data.toJson());

class DeliveryListModel {
  bool? success;
  String? message;
  int? total;
  Filter? filter;
  List<DeliveryDetails>? data;

  DeliveryListModel({
    this.success,
    this.message,
    this.total,
    this.filter,
    this.data,
  });

  factory DeliveryListModel.fromJson(Map<String, dynamic> json) => DeliveryListModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    data: json["data"] == null ? [] : List<DeliveryDetails>.from(json["data"]!.map((x) => DeliveryDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "filter": filter?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DeliveryDetails {
  int? purchaseDeliveryId;
  int? yarnPurchaseId;
  DateTime? deliveryDate;
  String? deliveredBoxCount;
  String? rate;
  String? grossWeight;
  String? netWeight;
  String? cops;
  String? denier;
  String? purchaseAmount;
  String? paymentType;
  DateTime? paymentDueDate;
  String? dharaDays;
  String? paidStatus;
  String? paymentMethod;
  dynamic paymentDate;
  String? paymentNotes;
  String? paidAmount;
  String? billReceived;
  String? billUrl;
  String? gstBillAmount;

  DeliveryDetails({
    this.purchaseDeliveryId,
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

  factory DeliveryDetails.fromJson(Map<String, dynamic> json) => DeliveryDetails(
    purchaseDeliveryId: json["purchase_delivery_id"],
    yarnPurchaseId: json["yarn_purchase_id"],
    deliveryDate: json["delivery_date"] == null ? null : DateTime.parse(json["delivery_date"]),
    deliveredBoxCount: json["delivered_box_count"],
    rate: json["rate"],
    grossWeight: json["gross_weight"],
    netWeight: json["net_weight"],
    cops: json["cops"],
    denier: json["denier"],
    purchaseAmount: json["purchase_amount"],
    paymentType: json["payment_type"],
    paymentDueDate: json["payment_due_date"] == null ? null : DateTime.parse(json["payment_due_date"]),
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
    "purchase_delivery_id": purchaseDeliveryId,
    "yarn_purchase_id": yarnPurchaseId,
    "delivery_date": "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
    "delivered_box_count": deliveredBoxCount,
    "rate": rate,
    "gross_weight": grossWeight,
    "net_weight": netWeight,
    "cops": cops,
    "denier": denier,
    "purchase_amount": purchaseAmount,
    "payment_type": paymentType,
    "payment_due_date": "${paymentDueDate!.year.toString().padLeft(4, '0')}-${paymentDueDate!.month.toString().padLeft(2, '0')}-${paymentDueDate!.day.toString().padLeft(2, '0')}",
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

class Filter {
  String? paidStatus;
  String? billReceived;

  Filter({
    this.paidStatus,
    this.billReceived,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    paidStatus: json["paid_status"],
    billReceived: json["bill_received"],
  );

  Map<String, dynamic> toJson() => {
    "paid_status": paidStatus,
    "bill_received": billReceived,
  };
}
