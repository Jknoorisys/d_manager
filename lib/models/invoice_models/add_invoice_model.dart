import 'dart:convert';

AddInvoiceModel addInvoiceModelFromJson(String str) => AddInvoiceModel.fromJson(json.decode(str));

String addInvoiceModelToJson(AddInvoiceModel data) => json.encode(data.toJson());

class AddInvoiceModel {
  bool? success;
  String? message;

  AddInvoiceModel({
    this.success,
    this.message,
  });

  factory AddInvoiceModel.fromJson(Map<String, dynamic> json) => AddInvoiceModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
