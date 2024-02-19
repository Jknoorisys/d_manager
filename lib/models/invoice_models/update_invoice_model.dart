import 'dart:convert';

UpdateInvoiceModel updateInvoiceModelFromJson(String str) => UpdateInvoiceModel.fromJson(json.decode(str));

String updateInvoiceModelToJson(UpdateInvoiceModel data) => json.encode(data.toJson());

class UpdateInvoiceModel {
  bool? success;
  String? message;

  UpdateInvoiceModel({
    this.success,
    this.message,
  });

  factory UpdateInvoiceModel.fromJson(Map<String, dynamic> json) => UpdateInvoiceModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
