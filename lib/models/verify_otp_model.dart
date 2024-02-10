class VerifyOtpModel {
  String? status;
  String? otpVerified;
  String? email;
  String? message;

  VerifyOtpModel({this.status, this.otpVerified, this.email, this.message});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    otpVerified = json['otp_verified'];
    email = json['email'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['otp_verified'] = otpVerified;
    data['email'] = email;
    data['message'] = message;
    return data;
  }
}