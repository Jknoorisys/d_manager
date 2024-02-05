import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/images.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBody extends StatelessWidget {
  final Widget content;
  final bool? isAppBarTitle;
  final isBackgroundGradient;
  final Widget? bottomNavigationBar;

  const CustomBody({super.key, required this.content, this.isAppBarTitle = true, this.isBackgroundGradient = false, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isBackgroundGradient == false ?  AppTheme.notWhite : Colors.transparent,
      appBar: AppBar(
        backgroundColor: isBackgroundGradient == false ?  AppTheme.notWhite : AppTheme.secondaryLight,
        leading: IconButton(
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
          icon: FaIcon(FontAwesomeIcons.barsStaggered, color: AppTheme.primary, size: Dimensions.iconSize24),
        ),
        title: isAppBarTitle == true ? Image.asset(AppImages.appLogoHorizontal, width: Dimensions.width50*5, height: Dimensions.height50*5,) : null,
        centerTitle: true,
      ),
      body: isBackgroundGradient == false ? content : Container(
        height: Dimensions.screenHeight,
        decoration: const BoxDecoration(
          gradient: AppTheme.appGradientLight,
        ),
        child: content,
      ),
      bottomNavigationBar: bottomNavigationBar ,
    );
  }
}
