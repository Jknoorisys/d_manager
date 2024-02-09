class AddFirmModel {
  bool? success;
  String? message;
  Firm? firm;
  Account? account;

  AddFirmModel({this.success, this.message, this.firm, this.account});

  AddFirmModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    firm = json['firm'] != null ? new Firm.fromJson(json['firm']) : null;
    account =
    json['account'] != null ? new Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (firm != null) {
      data['firm'] = firm!.toJson();
    }
    if (account != null) {
      data['account'] = account!.toJson();
    }
    return data;
  }
}

class Firm {
  String? firmName;
  String? ownerName;
  String? phoneNumber;
  String? gstNumber;
  String? address;
  int? firmId;

  Firm(
      {this.firmName,
        this.ownerName,
        this.phoneNumber,
        this.gstNumber,
        this.address,
        this.firmId
      });

  Firm.fromJson(Map<String, dynamic> json) {
    firmName = json['firm_name'];
    ownerName = json['owner_name'];
    phoneNumber = json['phone_number'];
    gstNumber = json['gst_number'];
    address = json['address'];
    firmId = json['firm_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firm_name'] = firmName;
    data['owner_name'] = ownerName;
    data['phone_number'] = phoneNumber;
    data['gst_number'] = gstNumber;
    data['address'] = address;
    data['firm_id'] = firmId;
    return data;
  }
}

class Account {
  String? accountHolderName;
  String? bankName;
  String? ifscCode;
  String? accountNumber;
  int? accountId;

  Account(
      {
        this.accountHolderName,
        this.bankName,
        this.ifscCode,
        this.accountNumber,
        this.accountId
      });

  Account.fromJson(Map<String, dynamic> json) {
    accountHolderName = json['account_holder_name'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    accountNumber = json['account_number'];
    accountId = json['account_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_holder_name'] = accountHolderName;
    data['bank_name'] = bankName;
    data['ifsc_code'] = ifscCode;
    data['account_number'] = accountNumber;
    data['account_id'] = accountId;
    return data;
  }
}