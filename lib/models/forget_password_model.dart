class ForgetPasswordModel {
  bool? success;
  String? email;
  String? message;

  ForgetPasswordModel({this.success, this.email, this.message});

  ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    email = json['email'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['email'] = email;
    data['message'] = message;
    return data;
  }
}