import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

  static Future<bool> setNotificationCount(int unreadCount) async {
    return pref.setInt("unreadCount", unreadCount);
  }
  static int getNotificationCount() {
    int? getYarn = pref.getInt('unreadCount');
    return getYarn ?? 0;
  }

  static Future<bool> setUserImage(String userImage) async {
    return pref.setString("UserImage", userImage);
  }

  static String getUserImage() {
    String? userImage = pref.getString('UserImage');
    return userImage ?? '';
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

  // Dates for dashboard
  static Future<bool> setStartDate(String startDate) async {
    return pref.setString("startDate", startDate);
  }
  static String getStartDate() {
    String? startDate = pref.getString('startDate');
    return startDate ?? '';
  }
  static Future<bool> setEndDate(String endDate) async {
    return pref.setString("endDate", endDate);
  }
  static String getEndDate() {
    String? endDate = pref.getString('endDate');
    return endDate ?? '';
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

  static Future<bool> isNetworkResponsive() async {
    final url = Uri.parse('https://google.com');
    try {
      final response = await http.head(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (e) {
      return false;
    } catch (e) {
      // Handle other errors
      return false;
    }
  }

  static Future<bool> isInternetAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection
      return false;
    } else {
      // Internet connection is available
      return true;
    }
  }

  static Future<bool> isPossiblyNetworkAvailable() async {
    return await isInternetAvailable() && await isNetworkResponsive();
  }

  static Future<File?> imagePicker(ImageSource source) async {
    try {
      XFile? file = await ImagePicker().pickImage(
          source: source,
          imageQuality: 50);
      if (file != null) {
        final extension = file.name.split('.')[1];
        if(File(file.path) != null){
          return Future.value(File(file.path));
        }else{
          return null;
        }
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
