import 'dart:async';

import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/screens/widgets/animated_logo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isLoggedIn = HelperFunctions.getLoginStatus();
    Future.delayed(const Duration(seconds: 2), () {
      if (isLoggedIn == true) {
        Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body : Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.appGradientLight,
        ),
        child: const Center(
          child: AnimatedLogo(),
        ),
      ),
    );
  }
}
