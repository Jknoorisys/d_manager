import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/images.dart';
import 'package:d_manager/screens/manage_inventory/inventory_dashboard.dart';
import 'package:d_manager/screens/manage_inventory/purchase_inventory_list.dart';
import 'package:d_manager/screens/manage_inventory/sell_inventory_list.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Inventory extends StatefulWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const SellInventoryList(),
    const PurchaseInventoryList(),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      content: CustomBody(
        dashboardCard: const InventoryDashboard(),
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
                buttonText: 'Cloth',
                image: SvgPicture.asset(
                  AppImages.salesFillIcon,
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
                buttonText: 'Yarn',
                image: SvgPicture.asset(
                  AppImages.purchaseFillIcon,
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
