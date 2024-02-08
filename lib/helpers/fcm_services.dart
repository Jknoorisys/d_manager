import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
bool isInNotification = false;

FCMServices fcmServices = FCMServices();

class FCMServices {
  static final FCMServices _singleton = FCMServices._internal();

  FCMServices._internal();

  factory FCMServices() {
    return _singleton;
  }

  late final FirebaseMessaging _messaging;

  static const String notificationIcon = "@drawable/ic_notification";
  static const String channelID = "high_importance_channel";
  static const String channelName = "High Importance Notifications";
  static const String channelDescription = "High Importance Notifications";

  Future<String> getFCMToken() async {
    try {
      final fcmToken = await _messaging.getToken();
      debugPrint("fcm token $fcmToken");
      return fcmToken ?? 'failed_to_get_device_fcm_token';
    } catch (e) {
      debugPrint(e.toString());
      return 'failed_to_get_device_fcm_token';
    }
  }

  Future<void> deleteFCMToken() async {
    try {
      await _messaging.deleteToken();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void tokenListener() {
    _messaging.onTokenRefresh.listen((fcmToken) {
      if (kDebugMode) {
        debugPrint("FCM Token");
      }
    }).onError((err) {
      if (kDebugMode) {
        debugPrint(err);
      }
    });
  }
}