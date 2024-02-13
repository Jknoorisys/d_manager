import 'dart:async';
import 'dart:io';
import 'package:d_manager/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static bool trustSelfSigned = true;

  static late SharedPreferences pref;

  static Future init() async {
    pref = await SharedPreferences.getInstance();
  }
  static setLoginStatus(bool status) async {
    pref.setBool("LoginStatus", status);
  }

  static bool getLoginStatus()  {
    bool? status = pref.getBool('LoginStatus');
    return status ?? false;
  }

  static Future<bool> setUserID(String id) async {
    return pref.setString("UserID", id);
  }
  static String getUserID() {
    String? id = pref.getString('UserID');
    return id ?? '';
  }

  static Future<bool> setUserEmail(String email) async {
    return pref.setString("UserEmail", email);
  }

  static String getUserEmail() {
    String? email = pref.getString('UserEmail');
    return email ?? '';
  }

  static Future<bool> setUserName(String userName) async {
    return pref.setString("UserName", userName);
  }

  static String getUserName() {
    String? userName = pref.getString('UserName');
    return userName ?? '';
  }

  static Future<bool> setUserImage(String userImage) async {
    return pref.setString("UserImage", userImage);
  }

  static String getUserImage() {
    String? userImage = pref.getString('UserImage');
    return '$baseUrl/$userImage' ?? '';
  }

  static Future<bool> setApiKey(String apiKey) async {
    return pref.setString("ApiKey", apiKey);
  }

  static String getApiKey() {
    String? apiKey = pref.getString('ApiKey');
    return apiKey ?? '';
  }

  static Future<bool> setLanguage(String lang) async {
    return pref.setString("Language", lang);
  }

  static String getLanguage()  {
    String? lang = pref.getString('Language');
    return lang ?? 'en';
  }

  static Future<void> saveCredentials(String userEmail, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', userEmail);
    await prefs.setString('password', password);
  }

  static Future<Map<String, String>> getStoredCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('email');
    String? password = prefs.getString('password');

    return {'email': userEmail ?? '', 'password': password ?? ''};
  }

  static Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
