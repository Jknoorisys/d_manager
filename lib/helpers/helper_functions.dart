import 'dart:async';
import 'dart:io';
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
    bool? email = pref.getBool('LoginStatus');
    return email ?? false;
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

  static Future<bool> setLanguage(String lang) async {
    return pref.setString("Language", lang);
  }

  static String getLanguage()  {
    String? lang = pref.getString('Language');
    return lang ?? 'en';
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