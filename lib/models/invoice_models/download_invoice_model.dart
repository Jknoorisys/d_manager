import 'dart:convert';

DownloadInvoiceModel downloadInvoiceModelFromJson(String str) => DownloadInvoiceModel.fromJson(json.decode(str));

String downloadInvoiceModelToJson(DownloadInvoiceModel data) => json.encode(data.toJson());

class DownloadInvoiceModel {
  bool? success;
  String? message;
  String? path;

  DownloadInvoiceModel({
    this.success,
    this.message,
    this.path,
  });

  factory DownloadInvoiceModel.fromJson(Map<String, dynamic> json) => DownloadInvoiceModel(
    success: json["success"],
    message: json["message"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "path": path,
  };
}
