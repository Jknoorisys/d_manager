import 'dart:convert';
import 'dart:io';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/auth_models/change_password_model.dart';
import 'package:d_manager/models/auth_models/forget_password_model.dart';
import 'package:d_manager/models/auth_models/login_model.dart';
import 'package:d_manager/models/auth_models/reset_password_model.dart';
import 'package:d_manager/models/auth_models/verify_otp_model.dart';
import 'package:http/http.dart';

class AuthServices {
  Future<LoginModel?> login(String email, String? password) async {
    try {
      String deviceType = Platform.isAndroid ? "android" : "ios";
      Map<String, dynamic> body = {
        "email": email,
        "password": password,
        "device_type": deviceType,
        "device_token": "deviceToken",
        "fcm_token": 'fcmToken',
      };
      Response response = await post(Uri.parse(loginUrl), body: body);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return LoginModel.fromJson(data);
      } else {
        return LoginModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }

  Future<ForgetPasswordModel> forgotPassword(String email) async {
    try {
      Map<String, dynamic> body = {
        "email": email,
      };
      Response response = await post(Uri.parse(forgotPasswordUrl), body: body);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return ForgetPasswordModel.fromJson(data);
      } else {
        return ForgetPasswordModel.fromJson(data);
      }
    } catch (e) {
      return ForgetPasswordModel();
    }
  }

  Future<VerifyOtpModel> verifyOtp(String email, String otp) async {
    try {
      Map<String, dynamic> body = {
        "email": email,
        "otp": otp,
      };
      Response response = await post(Uri.parse(verifyOtpUrl), body: body);
      print(response.body);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return VerifyOtpModel.fromJson(data);
      } else {
        return VerifyOtpModel.fromJson(data);
      }
    } catch (e) {
      return VerifyOtpModel();
    }
  }

  Future<ResetPasswordModel> resetPassword(String email, String password, String confirmPassword) async {
    try {
      Map<String, dynamic> body = {
        "email": email,
        "new_password": password,
        "new_confirm_password": confirmPassword,
      };

      Response response = await post(Uri.parse(resetPasswordUrl), body: body);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return ResetPasswordModel.fromJson(data);
      } else {
        return ResetPasswordModel.fromJson(data);
      }
    } catch (e) {
      return ResetPasswordModel();
    }
  }

  Future<ChangePasswordModel> changePassword(String oldPassword, String password, String confirmPassword) async {
    try {
      Map<String, dynamic> body = {
        "user_id": HelperFunctions.getUserID(),
        "password": oldPassword,
        "new_password": password,
        "new_confirm_password": confirmPassword,
      };

      Map<String, String> headers = {
        "X-API-Key": HelperFunctions.getApiKey(),
      };

      Response response = await post(Uri.parse(changePasswordUrl), body: body, headers: headers);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return ChangePasswordModel.fromJson(data);
      } else {
        return ChangePasswordModel.fromJson(data);
      }
    } catch (e) {
      return ChangePasswordModel();
    }
  }

}