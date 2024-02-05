import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/screens/dashboard/dashboard.dart';
import 'package:d_manager/screens/widgets/drawer/drawer_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class CustomDrawer extends StatelessWidget {
  final Widget content;
  const CustomDrawer({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: const DrawerItems(),
      mainScreen: content,
      borderRadius: 24.0,
      showShadow: true,
      angle: 0.0,
      // mainScreenScale: 0.25,
      menuBackgroundColor: AppTheme.nearlyBlack,
      slideWidth: MediaQuery.of(context).size.width * (0.72),
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
    );
  }
}
