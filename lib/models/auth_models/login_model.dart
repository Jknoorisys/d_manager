// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? success;
  String? message;
  Data? data;

  LoginModel({
    this.success,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
  String? apiKey;
  int? userId;
  String? userName;
  String? email;
  String? profilePic;
  int? isSocial;
  String? socialId;
  String? deviceType;
  String? deviceToken;
  String? fcmToken;

  Data({
    this.apiKey,
    this.userId,
    this.userName,
    this.email,
    this.profilePic,
    this.isSocial,
    this.socialId,
    this.deviceType,
    this.deviceToken,
    this.fcmToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    apiKey: json["X-API-Key"],
    userId: json["user_id"],
    userName: json["user_name"],
    email: json["email"],
    profilePic: json["profile_pic"],
    isSocial: json["is_social"],
    socialId: json["social_id"],
    deviceType: json["device_type"],
    deviceToken: json["device_token"],
    fcmToken: json["fcm_token"],
  );

  Map<String, dynamic> toJson() => {
    "X-API-Key": apiKey,
    "user_id": userId,
    "user_name": userName,
    "email": email,
    "profile_pic": profilePic,
    "is_social": isSocial,
    "social_id": socialId,
    "device_type": deviceType,
    "device_token": deviceToken,
    "fcm_token": fcmToken,
  };
}
