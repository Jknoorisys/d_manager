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

enum SnackbarMode { success, error, warning }
class CustomApiSnackbar {
  static void show(BuildContext context, String title, String message, {SnackbarMode mode = SnackbarMode.success}) {
    Color backgroundColor;
    Color color = AppTheme.white;
    IconData icon;

    // Determine background color and icon based on the mode
    switch (mode) {
      case SnackbarMode.success:
        backgroundColor = AppTheme.secondary;
        color = AppTheme.white;
        icon = Icons.check_circle;
        break;
      case SnackbarMode.error:
        backgroundColor = const Color(0xFFFF6B6B);
        color = AppTheme.white;
        icon = Icons.error;
        break;
      case SnackbarMode.warning:
        backgroundColor = const Color(0xFFFFD166);
        color = AppTheme.white;
        icon = Icons.warning;
        break;
    }

    // Create the custom snackbar
    final snackbar = SnackBar(
      showCloseIcon: true,
      closeIconColor: AppTheme.white,
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius10),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.white, size: Dimensions.height40,),
          SizedBox(width: Dimensions.width20),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.subtitle.copyWith(color: color, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: Dimensions.height10/5),
                Text(
                  message,
                  style: AppTheme.body2.copyWith(color: color, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // Show the snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}