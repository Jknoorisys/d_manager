import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/images.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../gst_return/gst_return_amount.dart';

class DrawerItems extends StatelessWidget {
  const DrawerItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.nearlyBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    ZoomDrawer.of(context)!.toggle();
                  },
                  icon: const Icon(Icons.close, color: AppTheme.secondaryLight)
              ),

              SizedBox(height: Dimensions.height10),

              // User Profile
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: Dimensions.height40,
                      backgroundImage: const AssetImage(AppImages.userImage),
                    ),
                    SizedBox(height: Dimensions.height10),
                    SmallText(text: HelperFunctions.getUserName(), color: AppTheme.secondaryLight, size: Dimensions.font14),
                    SizedBox(height: Dimensions.height10/2),
                    SmallText(text: HelperFunctions.getUserEmail(), color: AppTheme.secondaryLight, size: Dimensions.font14),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height25),

              // Dashboard
              buildTitle(S.of(context).dashboard, Icons.home, () {
                Navigator.of(context).pushNamed(AppRoutes.dashboard);
              }),
              
              // Manage GST return amount screen
              buildTitle(S.of(context).returnGstAmount, Icons.bar_chart, () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GSTReturnAmount(),));
              }),
              
              // Manage Yarn Purchase Deal
              buildTitle(S.of(context).yarnPurchaseDeal, Icons.list, () {
                Navigator.of(context).pushNamed(AppRoutes.yarnPurchaseList);
              }),

              // Manage Cloth Sell Deal
              buildTitle(S.of(context).clothSellDeal, Icons.edit, () {
                Navigator.of(context).pushNamed(AppRoutes.clothSellList);
              }),

              // Manage Reminders
              ExpansionTile(
                shape: InputBorder.none,
                childrenPadding: EdgeInsets.only(left: Dimensions.width20),
                leading: Icon(Icons.notifications, color: AppTheme.secondaryLight, size: Dimensions.font22,),
                title: SmallText(text: S.of(context).reminders, color: AppTheme.secondaryLight, size: Dimensions.font15),
                trailing: const Icon(Icons.arrow_drop_down, color: AppTheme.secondaryLight),
                children: [
                  buildTitle(S.of(context).yarnPurchase, Icons.arrow_right, () {
                    Navigator.of(context).pushNamed(AppRoutes.boxToBeReceived);
                  }, S.of(context).boxToBeReceived),
                  buildTitle(S.of(context).yarnPurchase, Icons.arrow_right, () {
                    Navigator.of(context).pushNamed(AppRoutes.paymentDueDate);
                  }, S.of(context).paymentDueDate),
                  buildTitle(S.of(context).clothSell, Icons.arrow_right, () {
                    Navigator.of(context).pushNamed(AppRoutes.thansToBeDelivered);
                  }, S.of(context).thansToBeDelivered),
                  buildTitle(S.of(context).clothSell, Icons.arrow_right, () {
                    Navigator.of(context).pushNamed(AppRoutes.paymentToBeReceived);
                  }, S.of(context).paymentToBeReceived),
                ],
              ),

              // Manage History
              ExpansionTile(
                shape: InputBorder.none,
                childrenPadding: EdgeInsets.only(left: Dimensions.width20),
                leading: Icon(Icons.manage_history, color: AppTheme.secondaryLight, size: Dimensions.font22,),
                title: SmallText(text: S.of(context).history, color: AppTheme.secondaryLight, size: Dimensions.font15),
                trailing: const Icon(Icons.arrow_drop_down, color: AppTheme.secondaryLight),
                children: [
                  buildTitle(S.of(context).purchaseHistory, Icons.arrow_right, () {
                    Navigator.of(context).pushNamed(AppRoutes.purchaseHistory);
                  }),
                  buildTitle(S.of(context).sellHistory, Icons.arrow_right, () {
                    Navigator.of(context).pushNamed(AppRoutes.sellHistory);
                  }),
                ],
              ),

              // Manage Masters
              ExpansionTile(
                shape: InputBorder.none,
                childrenPadding: EdgeInsets.only(left: Dimensions.width20),
                leading: Icon(Icons.dashboard_customize, color: AppTheme.secondaryLight, size: Dimensions.font22,),
                title: SmallText(text: S.of(context).masters, color: AppTheme.secondaryLight, size: Dimensions.font15),
                trailing: const Icon(Icons.arrow_drop_down, color: AppTheme.secondaryLight),
                children: [
                  buildTitle(S.of(context).myFirm, Icons.arrow_right, () {
                    Navigator.of(context).pushNamed(AppRoutes.firmList);
                  }),
                  buildTitle(S.of(context).party, Icons.arrow_right, () {
                    Navigator.of(context).pushNamed(AppRoutes.partyList);
                  }),
                  buildTitle(S.of(context).clothQuality, Icons.arrow_right, () {
                    Navigator.of(context).pushNamed(AppRoutes.clothQualityList);
                  }),
                  buildTitle(S.of(context).yarnType, Icons.arrow_right, () {
                    Navigator.of(context).pushNamed(AppRoutes.yarnTypeList);
                  }),
                  buildTitle(S.of(context).transport, Icons.arrow_right, () {
                    Navigator.of(context).pushNamed(AppRoutes.transportList);
                  }),
                  buildTitle(S.of(context).hammal, Icons.arrow_right, () {
                    Navigator.of(context).pushNamed(AppRoutes.hammalList);
                  }),
                ],
              ),

              // Change Password
              buildTitle(S.of(context).settings, Icons.settings, () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.settings);
              }),

              // Logout
              buildTitle(S.of(context).logout, Icons.logout, () {
                HelperFunctions.setLoginStatus(false);
                Navigator.of(context).pushReplacementNamed(AppRoutes.login);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitle(String title, IconData icon, Function() onTap, [String? subTitle]) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.secondaryLight, size: Dimensions.font22,),
      title: SmallText(text: title, color: AppTheme.secondaryLight, size: Dimensions.font15),
      subtitle: subTitle != null ? SmallText(text: subTitle, color: AppTheme.secondaryLight, size: Dimensions.font12) : null,
      onTap: onTap,
    );
  }

}
