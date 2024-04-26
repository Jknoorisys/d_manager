import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/images.dart';
import 'package:d_manager/screens/manage_history/unpaid_history/unpaid_history_card.dart';
import 'package:d_manager/screens/manage_history/unpaid_history/unpaid_provider.dart';
import 'package:d_manager/screens/manage_history/unpaid_history/unpaid_purchase.dart';
import 'package:d_manager/screens/manage_history/unpaid_history/unpaid_sells.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class UnpaidHistory extends StatefulWidget {
  const UnpaidHistory({Key? key}) : super(key: key);

  @override
  _UnpaidHistoryState createState() => _UnpaidHistoryState();
}

class _UnpaidHistoryState extends State<UnpaidHistory> {
  int _currentIndex = 0;
  late Widget dynamicDashboardCard = const UnpaidHistoryCard(
    image: AppImages.purchaseIcon,
  );
  final List<Widget> _pages = [
    const UnpaidPurchase(),
    const UnpaidSells(),
  ];

  @override
  Widget build(BuildContext context) {
    Provider.of<UnpaidProvider>(context, listen: false).setTotalUnpaidAmount("0.00");

    return CustomDrawer(
      content: CustomBody(
        dashboardCard: dynamicDashboardCard,
        content: _pages.isNotEmpty ? _pages[_currentIndex] : const SizedBox(),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(Dimensions.width20),
          height: Dimensions.height60 + Dimensions.height10,
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20),
              topRight: Radius.circular(Dimensions.radius20),
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.grey.withOpacity(0.4),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                buttonText: 'Purchase',
                image: SvgPicture.asset(
                  AppImages.purchaseFillIcon,
                  color: _currentIndex == 0
                      ? AppTheme.white
                      : AppTheme.primary,
                  width: Dimensions.iconSize24,
                  height: Dimensions.iconSize24,
                ),
                isBackgroundGradient: _currentIndex == 0,
                color: _currentIndex == 0
                    ? AppTheme.white
                    : AppTheme.primary,
              ),
              CustomElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                buttonText: 'Sell',
                image: SvgPicture.asset(
                  AppImages.salesFillIcon,
                  color: _currentIndex == 1
                      ? AppTheme.white
                      : AppTheme.primary,
                  width: Dimensions.iconSize24,
                  height: Dimensions.iconSize24,
                ),
                isBackgroundGradient: _currentIndex == 1,
                color: _currentIndex == 1
                    ? AppTheme.white
                    : AppTheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
