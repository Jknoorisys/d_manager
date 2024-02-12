import 'dart:convert';

FirmDetailModel firmDetailModelFromJson(String str) => FirmDetailModel.fromJson(json.decode(str));

String firmDetailModelToJson(FirmDetailModel data) => json.encode(data.toJson());

class FirmDetailModel {
  bool? success;
  String? message;
  FirmDetails? data;

  FirmDetailModel({
    this.success,
    this.message,
    this.data,
  });

  factory FirmDetailModel.fromJson(Map<String, dynamic> json) => FirmDetailModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : FirmDetails.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
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
