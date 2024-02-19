import 'dart:convert';

UpdateInvoiceStatusModel updateInvoiceStatusModelFromJson(String str) => UpdateInvoiceStatusModel.fromJson(json.decode(str));

String updateInvoiceStatusModelToJson(UpdateInvoiceStatusModel data) => json.encode(data.toJson());


class UpdateInvoiceStatusModel {
  bool? success;
  String? message;

  UpdateInvoiceStatusModel({
    this.success,
    this.message,
  });

  factory UpdateInvoiceStatusModel.fromJson(Map<String, dynamic> json) => UpdateInvoiceStatusModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
