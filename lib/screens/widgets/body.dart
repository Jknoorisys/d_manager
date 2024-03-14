import 'package:d_manager/api/notification_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/images.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/notification_models/notification_list_model.dart';
import 'package:d_manager/screens/widgets/no_internet_connection.dart';
import 'package:d_manager/screens/widgets/no_record_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';

import '../../constants/routes.dart';

class CustomBody extends StatefulWidget {
  final Widget content;
  final bool? isAppBarTitle;
  final isBackgroundGradient;
  final Widget? bottomNavigationBar;
  final String? title;
  final Widget? filterButton;
  final Widget? dashboardCard;

  final bool? isLoading;
  final bool? noRecordFound;
  final bool? internetNotAvailable;

  const CustomBody({super.key, required this.content, this.isAppBarTitle = true, this.isBackgroundGradient = false, this.bottomNavigationBar, this.title, this.filterButton, this.dashboardCard, this.isLoading = false, this.noRecordFound = false, this.internetNotAvailable = true});

  @override
  State<CustomBody> createState() => _CustomBodyState();
}

class _CustomBodyState extends State<CustomBody> {
  @override
  void initState() {
    super.initState();
    _notificationCount(1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isBackgroundGradient == false ?  AppTheme.notWhite : Colors.transparent,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppTheme.secondary,
        ),
        backgroundColor: widget.isBackgroundGradient == false ?  AppTheme.notWhite : AppTheme.secondaryLight,
        leading: IconButton(
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
          icon: FaIcon(FontAwesomeIcons.barsStaggered, color: AppTheme.primary, size: Dimensions.iconSize24),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.notificationList);
                },
                icon: FaIcon(FontAwesomeIcons.bell, color: AppTheme.primary, size: Dimensions.iconSize16*2),
              ),
              if (HelperFunctions.getNotificationCount() > 0)
                Positioned(
                  top: Dimensions.height10,
                  right:Dimensions.width15,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                 HelperFunctions.getNotificationCount().toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.font12,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
        title: widget.isAppBarTitle == true ? Image.asset(AppImages.appLogoHorizontal, width: Dimensions.width50*5, height: Dimensions.height50*5,) : null,
        centerTitle: true,
      ),
      body: widget.isBackgroundGradient == false ? _buildContent() : Container(
        height: Dimensions.screenHeight,
        decoration: const BoxDecoration(
          gradient: AppTheme.appGradientLight,
        ),
        child: Stack(
          children: [
            widget.content,
            if (widget.isLoading == true)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: GFLoader(
                    type: GFLoaderType.circle,
                    loaderColorOne: AppTheme.primary,
                    loaderColorTwo: AppTheme.secondary,
                    loaderColorThree: AppTheme.secondaryLight,
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: widget.bottomNavigationBar ,
    );
  }

  _buildContent(){
    return Stack(
      children: [
        Column(
          children: [
            widget.title != null ? Container(
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
                   Text(widget.title!, style: AppTheme.headline),
                    widget.filterButton ?? Container(),
                  ],
                ),
              )
            ) : Container(),
            widget.title != null ?  SizedBox(height: Dimensions.width10,) : Container(),
            widget.dashboardCard ?? Container(),
            widget.dashboardCard != null ? Padding(
                padding: EdgeInsets.only(left:Dimensions.height30 , right: Dimensions.height30, top: Dimensions.height10),
                child: AppTheme.divider,
            ) : Container(),
            Expanded(
              child: widget.internetNotAvailable == true ? (widget.noRecordFound == false ? widget.content : const NoRecordFound()) : const NoInternetConnection(),
            ),
          ],
        ),
        if (widget.isLoading == true)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: GFLoader(
                type: GFLoaderType.circle,
                loaderColorOne: AppTheme.primary,
                loaderColorTwo: AppTheme.secondary,
                loaderColorThree: AppTheme.secondaryLight,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _notificationCount(int pageNo) async {
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      NotificationListModel? notificationListModel = await NotificationServices().notificationList(pageNo);
      if (notificationListModel != null) {
        if (notificationListModel.success == true) {
          if (notificationListModel.notification != null) {
            if (notificationListModel.notification!.isNotEmpty) {
              HelperFunctions.setNotificationCount(notificationListModel.totalUnseen!.toInt());
            }
          }
        }
      }
    }
  }
}
