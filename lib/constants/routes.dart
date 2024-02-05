import 'package:d_manager/screens/auth/forgot_password.dart';
import 'package:d_manager/screens/auth/forgot_password_code.dart';
import 'package:d_manager/screens/auth/login.dart';
import 'package:d_manager/screens/auth/set_new_password.dart';
import 'package:d_manager/screens/change_password/change_password.dart';
import 'package:d_manager/screens/dashboard/dashboard.dart';
import 'package:d_manager/screens/manage_masters/manage_cloth_quality/cloth_quality_add.dart';
import 'package:d_manager/screens/manage_masters/manage_cloth_quality/cloth_quality_list.dart';
import 'package:d_manager/screens/manage_masters/manage_firm/firm_add.dart';
import 'package:d_manager/screens/manage_masters/manage_firm/firm_list.dart';
import 'package:d_manager/screens/manage_masters/manage_party/party_add.dart';
import 'package:d_manager/screens/manage_masters/manage_party/party_list.dart';
import 'package:d_manager/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String forgotPasswordCode = '/forgot-password-code';
  static const String setNewPassword = '/set-new-password';
  static const String dashboard = '/dashboard';
  static const String settings = '/settings';

  // Manage My Firm
  static const String firmAdd = '/firm-add';
  static const String firmList = '/firm-list';

  // Manage Party
  static const String partyAdd = '/party-add';
  static const String partyList = '/party-list';

  // Manage Cloth Quality
  static const String clothQualityList = '/cloth-quality-list';

  static final Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    forgotPassword: (context) => const ForgotPasswordScreen(),
    forgotPasswordCode: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final String? emailAddress = args?['emailAddress'];
      return PinCodeVerificationScreen(emailAddress: emailAddress);
    },
    setNewPassword: (context) => const SetNewPasswordScreen(),
    dashboard: (context) => const DashboardScreen(),
    settings: (context) => const ChangePasswordScreen(),

    // Manage My Firm
    firmList: (context) => const FirmList(),
    firmAdd: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final Map<String, dynamic>? firmData = args?['firmData'];
      return FirmAdd(firmData: firmData);
    },

    // Manage Party
    partyList: (context) => const PartyList(),
    partyAdd: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final Map<String, dynamic>? partyData = args?['partyData'];
      return PartyAdd(partyData: partyData);
    },

    // Manage Cloth Quality
    clothQualityList: (context) => const ClothQualityList(),
  };
}
