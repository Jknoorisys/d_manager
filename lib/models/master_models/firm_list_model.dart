import 'dart:convert';

FirmListModel firmListModelFromJson(String str) => FirmListModel.fromJson(json.decode(str));

String firmListModelToJson(FirmListModel data) => json.encode(data.toJson());

class FirmListModel {
  bool? success;
  String? message;
  int? total;
  List<FirmDetails>? data;

  FirmListModel({
    this.success,
    this.message,
    this.total,
    this.data,
  });

  factory FirmListModel.fromJson(Map<String, dynamic> json) => FirmListModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    data: json["data"] == null ? [] : List<FirmDetails>.from(json["data"]!.map((x) => FirmDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FirmDetails {
  int? firmId;
  String? firmName;
  String? ownerName;
  String? address;
  String? gstNumber;
  String? panNumber;
  String? groupCode;
  String? phoneNumber;
  String? status;
  BankDetails? bankDetails;

  FirmDetails({
    this.firmId,
    this.firmName,
    this.ownerName,
    this.address,
    this.gstNumber,
    this.panNumber,
    this.groupCode,
    this.phoneNumber,
    this.status,
    this.bankDetails,
  });

  factory FirmDetails.fromJson(Map<String, dynamic> json) => FirmDetails(
    firmId: json["firm_id"],
    firmName: json["firm_name"],
    ownerName: json["owner_name"],
    address: json["address"],
    gstNumber: json["gst_number"],
    panNumber: json["pan_number"],
    groupCode: json["group_code"],
    phoneNumber: json["phone_number"],
    status: json["status"],
    bankDetails: json["bank_details"] == null ? null : BankDetails.fromJson(json["bank_details"]),
  );

  Map<String, dynamic> toJson() => {
    "firm_id": firmId,
    "firm_name": firmName,
    "owner_name": ownerName,
    "address": address,
    "gst_number": gstNumber,
    "group_code": groupCode,
    "phone_number": phoneNumber,
    "status": status,
    "bank_details": bankDetails?.toJson(),
  };
}

class BankDetails {
  String? bankName;
  String? accountHolderName;
  String? accountNumber;
  String? ifscCode;

  BankDetails({
    this.bankName,
    this.accountHolderName,
    this.accountNumber,
    this.ifscCode,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
    bankName: json["bank_name"],
    accountHolderName: json["account_holder_name"],
    accountNumber: json["account_number"],
    ifscCode: json["ifsc_code"],
  );

  Map<String, dynamic> toJson() => {
    "bank_name": bankName,
    "account_holder_name": accountHolderName,
    "account_number": accountNumber,
    "ifsc_code": ifscCode,
  };
}
