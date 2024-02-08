import 'dart:io';
import 'package:d_manager/constants/constants.dart';
import 'package:d_manager/helpers/fcm_services.dart';
import 'package:d_manager/models/login_model.dart';
import 'package:dio/dio.dart';

final dio = Dio();
class AuthServices {
  Future<LoginModel?> login(String email, String? password) async {
    try {
      String deviceType = Platform.isAndroid ? "android" : "ios";
      Map<String, dynamic> body = {
        "email": email,
        "password": password,
        "device_type": deviceType,
        "device_token": await fcmServices.getFCMToken() ?? "",
      };

      Response response = await dio.post(loginUrl, data: body);
      if (response.statusCode == 200) {
       print("Log In - ${response.data}");
        return LoginModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}