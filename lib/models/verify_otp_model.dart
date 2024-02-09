class VerifyOtpModel {
  bool? success;
  String? otpVerified;
  String? email;
  String? message;

  VerifyOtpModel({this.success, this.otpVerified, this.email, this.message});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    otpVerified = json['otp_verified'];
    email = json['email'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['otp_verified'] = otpVerified;
    data['email'] = email;
    data['message'] = message;
    return data;
  }
}