import 'dart:async';

import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/images.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    controller.forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOutSine );
    Timer(const Duration(seconds: 4), (){
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    } );
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
    ),
      child:Scaffold(
      backgroundColor: Colors.white,
      body : Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.appGradientLight,
        ),
        child: Center(
          child: ScaleTransition(
            scale: animation,
            child: Image.asset(AppImages.appLogoTransparent, width: Dimensions.height50 * 3, height: Dimensions.height50 * 3,),
            ),
          ),
        ),
      )
    );
  }
}
