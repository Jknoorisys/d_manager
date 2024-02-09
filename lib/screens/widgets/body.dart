import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBody extends StatelessWidget {
  final Widget content;
  final bool? isAppBarTitle;
  final isBackgroundGradient;
  final Widget? bottomNavigationBar;

  final String? title;
  final Widget? filterButton;
  final Widget? dashboardCard;

  const CustomBody({super.key, required this.content, this.isAppBarTitle = true, this.isBackgroundGradient = false, this.bottomNavigationBar, this.title, this.filterButton, this.dashboardCard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isBackgroundGradient == false ?  AppTheme.notWhite : Colors.transparent,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppTheme.secondary,
        ),
        backgroundColor: isBackgroundGradient == false ?  AppTheme.notWhite : AppTheme.secondaryLight,
        leading: IconButton(
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
          icon: FaIcon(FontAwesomeIcons.barsStaggered, color: AppTheme.primary, size: Dimensions.iconSize24),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.bell, color: AppTheme.primary, size: Dimensions.iconSize24),
          ),
        ],
        title: isAppBarTitle == true ? Image.asset(AppImages.appLogoHorizontal, width: Dimensions.width50*5, height: Dimensions.height50*5,) : null,
        centerTitle: true,
      ),
      body: isBackgroundGradient == false ? _buildContent() : Container(
        height: Dimensions.screenHeight,
        decoration: const BoxDecoration(
          gradient: AppTheme.appGradientLight,
        ),
        child: content,
      ),
      bottomNavigationBar: bottomNavigationBar ,
    );
  }

  _buildContent(){
    return Column(
      children: [
        title != null ? Container(
          width: Dimensions.screenWidth,
          decoration: BoxDecoration(
            color: AppTheme.secondary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Dimensions.radius30),
              bottomRight: Radius.circular(Dimensions.radius30),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: Dimensions.height15, horizontal: Dimensions.height30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Text(title!, style: AppTheme.headline),
                filterButton ?? Container(),
              ],
            ),
          )
        ) : Container(),
        title != null ?  SizedBox(height: Dimensions.width10,) : Container(),
        dashboardCard ?? Container(),
        dashboardCard != null ? Padding(
            padding: EdgeInsets.only(left:Dimensions.height30 , right: Dimensions.height30, top: Dimensions.height10),
            child: AppTheme.divider,
        ) : Container(),
        Expanded(
          child: content,
        ),
      ],
    );
  }
}
