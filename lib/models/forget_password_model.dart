class ForgetPasswordModel {
  String? status;
  String? email;
  String? message;

  ForgetPasswordModel({this.status, this.email, this.message});

  ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    email = json['email'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['email'] = email;
    data['message'] = message;
    return data;
  }
}