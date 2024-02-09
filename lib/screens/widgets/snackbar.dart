import 'package:d_manager/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:d_manager/constants/dimension.dart';

class CustomSnackbar {
  static void show({
    required String title,
    required String message,
    SnackPosition? position,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    double? borderRadius,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
    bool shouldIconPulse = false,
  }) {
    Get.snackbar(

      title,
      message,
      snackPosition: position ?? SnackPosition.TOP,
      backgroundColor: backgroundColor ?? AppTheme.secondaryLight.withOpacity(0.9),
      colorText: textColor ?? AppTheme.black,
      margin: EdgeInsets.all(Dimensions.height10),
      borderRadius: borderRadius ?? Dimensions.radius10,
      duration: duration,
      icon: icon != null ? Icon(icon, color: iconColor ?? AppTheme.primary, size: Dimensions.height45,) : null,
      shouldIconPulse: shouldIconPulse,
      padding: EdgeInsets.all(Dimensions.height20),
      isDismissible: true,
    );
  }
}
