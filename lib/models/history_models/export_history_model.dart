import 'dart:convert';

ExportHistoryModel exportHistoryModelFromJson(String str) => ExportHistoryModel.fromJson(json.decode(str));

String exportHistoryModelToJson(ExportHistoryModel data) => json.encode(data.toJson());

class ExportHistoryModel {
  bool? success;
  String? message;
  String? filePath;

  ExportHistoryModel({
    this.success,
    this.message,
    this.filePath,
  });

  factory ExportHistoryModel.fromJson(Map<String, dynamic> json) => ExportHistoryModel(
    success: json["success"],
    message: json["message"],
    filePath: json["file_path"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "file_path": filePath,
  };
}
