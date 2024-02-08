class LoginModel {
  bool? success;
  String? message;
  Data? data;

  LoginModel({this.success, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? userName;
  String? userEmail;
  String? profilePic;
  bool? isSocial;
  String? socialId;
  String? deviceType;
  String? deviceToken;
  String? fcmToken;

  Data(
      {this.userId,
        this.userName,
        this.userEmail,
        this.profilePic,
        this.isSocial,
        this.socialId,
        this.deviceType,
        this.deviceToken,
        this.fcmToken});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userEmail = json['email'];
    profilePic = json['profile_pic'];
    isSocial = json['is_social'];
    socialId = json['social_id'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['email'] = userEmail;
    data['profile_pic'] = profilePic;
    data['is_social'] = isSocial;
    data['social_id'] = socialId;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['fcm_token'] = fcmToken;
    return data;
  }
}