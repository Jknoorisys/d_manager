import 'dart:async';

import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/screens/widgets/animated_logo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), (){
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      }
    );
  }
  @override
  Widget build(BuildContext context) {
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
