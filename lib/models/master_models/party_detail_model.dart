import 'dart:convert';

PartyDetailModel partyDetailModelFromJson(String str) => PartyDetailModel.fromJson(json.decode(str));

String partyDetailModelToJson(PartyDetailModel data) => json.encode(data.toJson());

class PartyDetailModel {
  bool? success;
  String? message;
  PartyDetails? data;

  PartyDetailModel({
    this.success,
    this.message,
    this.data,
  });

  factory PartyDetailModel.fromJson(Map<String, dynamic> json) => PartyDetailModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : PartyDetails.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class PartyDetails {
  int? partyId;
  String? partyName;
  String? firmName;
  String? address;
  String? gstNumber;
  String? panNumber;
  String? state;
  String? phoneNumber;
  String? status;
  BankDetails? bankDetails;

  PartyDetails({
    this.partyId,
    this.partyName,
    this.firmName,
    this.address,
    this.gstNumber,
    this.panNumber,
    this.state,
    this.phoneNumber,
    this.status,
    this.bankDetails,
  });

  factory PartyDetails.fromJson(Map<String, dynamic> json) => PartyDetails(
    partyId: json["party_id"],
    partyName: json["party_name"],
    firmName: json["firm_name"],
    address: json["address"],
    gstNumber: json["gst_number"],
    panNumber: json["pan_number"],
    state: json["state"],
    phoneNumber: json["phone_number"],
    status: json["status"],
    bankDetails: json["bank_details"] == null ? null : BankDetails.fromJson(json["bank_details"]),
  );

  Map<String, dynamic> toJson() => {
    "party_id": partyId,
    "party_name": partyName,
    "firm_name": firmName,
    "address": address,
    "gst_number": gstNumber,
    "state": state,
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
