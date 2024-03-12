import 'dart:convert';

LoginWithGoogleModel loginWithGoogleModelFromJson(String str) => LoginWithGoogleModel.fromJson(json.decode(str));

String loginWithGoogleModelToJson(LoginWithGoogleModel data) => json.encode(data.toJson());

class LoginWithGoogleModel {
  bool? success;
  String? message;
  Data? data;

  LoginWithGoogleModel({
    this.success,
    this.message,
    this.data,
  });

  factory LoginWithGoogleModel.fromJson(Map<String, dynamic> json) => LoginWithGoogleModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? userId;
  String? userName;
  String? email;
  dynamic otp;
  String? otpVerified;
  dynamic profilePic;
  int? isSocial;
  String? socialId;
  String? deviceType;
  String? deviceToken;
  dynamic fcmToken;
  dynamic createdAt;
  dynamic updatedAt;
  String? apiKey;

  Data({
    this.userId,
    this.userName,
    this.email,
    this.otp,
    this.otpVerified,
    this.profilePic,
    this.isSocial,
    this.socialId,
    this.deviceType,
    this.deviceToken,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
    this.apiKey,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    userName: json["user_name"],
    email: json["email"],
    otp: json["otp"],
    otpVerified: json["otp_verified"],
    profilePic: json["profile_pic"],
    isSocial: json["is_social"],
    socialId: json["social_id"],
    deviceType: json["device_type"],
    deviceToken: json["device_token"],
    fcmToken: json["fcm_token"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    apiKey: json["X-API-Key"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
    "email": email,
    "otp": otp,
    "otp_verified": otpVerified,
    "profile_pic": profilePic,
    "is_social": isSocial,
    "social_id": socialId,
    "device_type": deviceType,
    "device_token": deviceToken,
    "fcm_token": fcmToken,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "X-API-Key": apiKey,
  };
}
