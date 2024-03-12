import 'dart:convert';

PartyListModel partyListModelFromJson(String str) => PartyListModel.fromJson(json.decode(str));

String partyListModelToJson(PartyListModel data) => json.encode(data.toJson());

class PartyListModel {
  bool? success;
  String? message;
  int? total;
  List<PartyDetail>? data;

  PartyListModel({
    this.success,
    this.message,
    this.total,
    this.data,
  });

  factory PartyListModel.fromJson(Map<String, dynamic> json) => PartyListModel(
    success: json["success"],
    message: json["message"],
    total: json["total"],
    data: json["data"] == null ? [] : List<PartyDetail>.from(json["data"]!.map((x) => PartyDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "total": total,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PartyDetail {
  int? partyId;
  String? firmName;
  String? partyName;
  String? address;
  String? gstNumber;
  String? panNumber;
  String? phoneNumber;
  String? status;
  String? state;
  int? stateId;
  String? stateName;
  BankDetails? bankDetails;

  PartyDetail({
    this.partyId,
    this.firmName,
    this.partyName,
    this.address,
    this.gstNumber,
    this.panNumber,
    this.phoneNumber,
    this.status,
    this.stateId,
    this.state,
    this.stateName,
    this.bankDetails,
  });

  factory PartyDetail.fromJson(Map<String, dynamic> json) => PartyDetail(
    partyId: json["party_id"],
    firmName: json["firm_name"],
    partyName: json["party_name"],
    address: json["address"],
    gstNumber: json["gst_number"],
    panNumber: json["pan_number"],
    phoneNumber: json["phone_number"],
    status: json["status"],
    stateId: json["state_id"],
    state: json["state"],
    stateName: json["state_name"],
    bankDetails: json["bank_details"] == null ? null : BankDetails.fromJson(json["bank_details"]),
  );

  Map<String, dynamic> toJson() => {
    "party_id": partyId,
    "firm_name": firmName,
    "party_name": partyName,
    "address": address,
    "gst_number": gstNumber,
    "pan_number": panNumber,
    "phone_number": phoneNumber,
    "status": status,
    "state_id": stateId,
    "state": state,
    "state_name": stateName,
    "bank_details": bankDetails?.toJson(),
  };
}

class BankDetails {
  int? accountId;
  String? bankName;
  String? accountHolderName;
  String? accountNumber;
  String? ifscCode;

  BankDetails({
    this.accountId,
    this.bankName,
    this.accountHolderName,
    this.accountNumber,
    this.ifscCode,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
    accountId: json["account_id"],
    bankName: json["bank_name"],
    accountHolderName: json["account_holder_name"],
    accountNumber: json["account_number"],
    ifscCode: json["ifsc_code"],
  );

  Map<String, dynamic> toJson() => {
    "account_id": accountId,
    "bank_name": bankName,
    "account_holder_name": accountHolderName,
    "account_number": accountNumber,
    "ifsc_code": ifscCode,
  };
}
